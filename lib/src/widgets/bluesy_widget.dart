import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../framework/bluesy_service.dart';

abstract class BluesyWidget extends StatefulWidget {
  String get widgetName;

  @override
  _BluesyWidgetState createState() {
    return _BluesyWidgetState();
  }

  Widget build(
    BuildContext context,
    void Function(int newValue) setValueCallback,
    int currentValue,
  );
}

class _BluesyWidgetState extends State<BluesyWidget> {
  int _value = 0;
  String _name;
  BluesyService _bluetoothService;

  @override
  void initState() {
    _name = widget.widgetName;

    super.initState();
  }

  void setValue(int newValue) {
    _bluetoothService.send("$_name,$newValue;");
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    _bluetoothService = Provider.of<BluesyService>(context);
    _bluetoothService.addBluetoothListener((message) {
      print("Received message from Bluesy: " + message);

      int commaPos = message.lastIndexOf(",");
      int delimiterPos = message.lastIndexOf(";");
      String key = message.substring(0, commaPos);
      if (key == _name) {
        String valueStr = message.substring(commaPos + 1, delimiterPos);
        int value = int.parse(valueStr);
        setState(() {
          _value = value;
        });
      }
    });
    return widget.build(context, setValue, _value);
  }
}
