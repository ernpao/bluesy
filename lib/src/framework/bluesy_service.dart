import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class BluesyService extends ChangeNotifier {
  /// The name of the Bluetooth device to pair to
  String get deviceName;

  /// Connect to the device identified by [deviceName]
  Future<void> connect();

  /// Terminate the connection with the paired Bluetooth device
  Future<void> disconnect();

  /// Send a UTF8 encoded key-value string to the Bluetooth device.
  ///
  /// Messages must be of the format [key] (a string) -> comma -> [value] (an integer) -> semi-colon.
  ///
  /// Example: "sensor_reading,123;" where the [key] is "sensor_reading"
  /// and the [value] is 123.
  void send(String message);

  /// Adds a listener for Bluetooth messages.
  ///
  /// Messages received from the Bluetooth device are formatted
  /// as [key] (a string) -> comma -> [value] (an integer) -> semi-colon.
  ///
  /// Example: "sensor_reading,123;" where the [key] is "sensor_reading"
  /// and the [value] is 123.
  void addBluetoothListener(
    String name,
    void Function(String message) callback,
  );

  /// Flag that determines if the mobile device is paired with the
  /// target device identified by [deviceName]
  bool get isConnected;

  /// Flag that determines if the mobile device is attempting
  /// to connect with the
  /// target device identified by [deviceName]
  bool get isConnecting;
}

class BluesyGenericService extends BluesyService {
  final String pairedDeviceName;

  BluesyGenericService(this.pairedDeviceName);

  bool _isConnecting = false;
  BluetoothDevice? _device;
  BluetoothConnection? _connection;

  String _message = "";
  Map<String, Function(String)> _listeners = {};

  @override
  void dispose() {
    _connection?.dispose();
    super.dispose();
  }

  @override
  bool get isConnected {
    return (_connection == null) ? false : _connection!.isConnected;
  }

  @override
  Future<void> connect() async {
    if (isConnected) {
      disconnect(notifyListeners: false);
    }

    _isConnecting = true;
    notifyListeners();

    print('Bluesy connecting...');

    var devices = await FlutterBluetoothSerial.instance.getBondedDevices();

    if (devices.isEmpty) {
      print('No paired devices found!');
      _isConnecting = false;
      notifyListeners();
      return;
    }

    for (var i = 0; i < devices.length; i++) {
      var device = devices[i];
      if (device.name == pairedDeviceName) {
        print('Bluetooth device found: ${device.name}');
        _device = device;
        _isConnecting = true;
        notifyListeners();
        BluetoothConnection.toAddress(_device!.address).then((connection) {
          print('Connected to the device');
          _connection = connection;
          _connection!.input!.listen(
            (Uint8List data) {
              String incoming = ascii.decode(data);
              incoming.split("").forEach((char) {
                _message += char;
                if (char == ";") {
                  if (isConnected) {
                    print("Message recieved: $_message");
                    _listeners.keys.forEach((listenerName) {
                      _listeners[listenerName]!(_message);
                    });
                  }
                  _message = "";
                }
              });
            },
          );

          _isConnecting = false;

          notifyListeners();
        });
      }
    }
  }

  @override
  void send(String message) async {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(Uint8List.fromList(utf8.encode(message)));
      await _connection!.output.allSent;
    }
  }

  @override
  bool get isConnecting => _isConnecting;

  @override
  Future<void> disconnect({bool notifyListeners = true}) async {
    _connection?.dispose();
    _connection = null;
    _listeners = {};
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  @override
  void addBluetoothListener(
    String name,
    void Function(String message) callback,
  ) {
    // assert(!_listeners.keys.contains(name));
    _listeners[name] = callback;
  }

  @override
  String get deviceName => pairedDeviceName;
}

class BluesyHC05 extends BluesyGenericService {
  BluesyHC05() : super("HC-05");
}
