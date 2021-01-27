import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../framework/bluesy_service.dart';

abstract class BluesyWidget extends StatefulWidget {
  /// The key string assosciated with the property value of this widget
  final String propertyKey;

  BluesyWidget(this.propertyKey);

  @override
  _BluesyWidgetState createState() {
    return _BluesyWidgetState();
  }

  /// Builder method for a Bluesy widget. You can pass an integer to
  /// the [propertyValueSetter] function provided. Doing so will send a key-value pair
  /// message to the paired bluetooth device, with the key being the [propertyKey]
  /// string of the Bluesy widget.

  Widget build(
    BuildContext context,
    void Function(int value) propertyValueSetter,
    int currentPropertyValue,
  );
}

class _BluesyWidgetState extends State<BluesyWidget> {
  int _propertyValue = 0;
  BluesyService _bluetoothService;

  @override
  void initState() {
    super.initState();
  }

  void _setPropertyValue(int value) {
    _bluetoothService.send("${widget.propertyKey},$value;");
    setState(() {
      _propertyValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    _bluetoothService = Provider.of<BluesyService>(context);
    _bluetoothService.addBluetoothListener((message) {
      // print("Received message from Bluesy: " + message);

      int commaPos = message.lastIndexOf(",");
      int delimiterPos = message.lastIndexOf(";");
      String key = message.substring(0, commaPos);
      if (key == widget.propertyKey) {
        String valueStr = message.substring(commaPos + 1, delimiterPos);
        int value = int.parse(valueStr);
        setState(() {
          _propertyValue = value;
        });
      }
    });
    return widget.build(context, _setPropertyValue, _propertyValue);
  }
}
