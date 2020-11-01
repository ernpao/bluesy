import 'package:flutter/cupertino.dart';
import '../widgets/bluesy_widget.dart';

class SerialBluetoothToggleSwitch extends BluesyWidget {
  final String _widgetName;

  SerialBluetoothToggleSwitch(
    this._widgetName,
  );

  @override
  String get widgetName => _widgetName;

  @override
  Widget build(BuildContext context,
      void Function(int newValue) setValueCallback, int currentValue) {
    return CupertinoSwitch(
      value: currentValue == 1 ? true : false,
      onChanged: (isSwitchActive) {
        setValueCallback(isSwitchActive ? 1 : 0);
      },
    );
  }
}
