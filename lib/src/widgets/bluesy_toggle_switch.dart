import 'package:flutter/cupertino.dart';
import '../widgets/bluesy_widget.dart';

class SerialBluetoothToggleSwitch extends BluesyWidget {
  SerialBluetoothToggleSwitch(String propertyName) : super(propertyName);

  @override
  Widget build(
    BuildContext context,
    void Function(int newValue) setPropertyValue,
    int currentValue,
  ) {
    return CupertinoSwitch(
      value: currentValue == 1 ? true : false,
      onChanged: (isSwitchActive) {
        setPropertyValue(isSwitchActive ? 1 : 0);
      },
    );
  }
}
