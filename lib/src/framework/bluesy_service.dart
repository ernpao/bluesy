import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class BluesyService extends ChangeNotifier {
  String get deviceName;
  Future<void> connect();
  Future<void> disconnect();
  void send(String message);
  void addBluetoothListener(void Function(String message) listener);
  bool get isConnected;
  bool get isConnecting;
}

class BluesyHC05 extends BluesyService {
  final String _deviceName;

  bool _isConnecting = false;
  BluetoothDevice _device;
  BluetoothConnection _connection;

  String _message = "";
  List<Function> _listeners = List();

  BluesyHC05(String deviceName) : _deviceName = deviceName;

  @override
  void dispose() {
    _connection?.dispose();
    super.dispose();
  }

  @override
  bool get isConnected {
    return (_connection == null) ? false : _connection?.isConnected;
  }

  @override
  Future<void> connect() async {
    if (isConnected) {
      disconnect(notifyListeners: false);
    }

    _isConnecting = true;
    notifyListeners();

    FlutterBluetoothSerial.instance.getBondedDevices().then((devices) {
      for (var i = 0; i < devices.length; i++) {
        var device = devices[i];
        if (device.name == _deviceName) {
          _device = device;
          _isConnecting = true;
          notifyListeners();
          BluetoothConnection.toAddress(_device.address).then((connection) {
            print('Connected to the device');
            _connection = connection;
            _connection.input.listen(
              (Uint8List data) {
                String incoming = ascii.decode(data);
                incoming.split("").forEach((char) {
                  _message += char;
                  if (char == ";") {
                    if (isConnected) {
                      print("Data recieved: $_message");
                      _listeners.forEach((listener) {
                        listener(_message);
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
    });
  }

  @override
  void send(String message) async {
    if (_connection != null && _connection.isConnected) {
      _connection.output.add(utf8.encode(message));
      await _connection.output.allSent;
    }
  }

  @override
  bool get isConnecting => _isConnecting;

  @override
  Future<void> disconnect({bool notifyListeners = true}) async {
    _connection?.dispose();
    _connection = null;
    _listeners = new List();
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  @override
  void addBluetoothListener(void Function(String message) listener) {
    _listeners.add(listener);
  }

  @override
  String get deviceName => _deviceName;
}
