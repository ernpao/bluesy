import 'package:flutter/cupertino.dart';
import '../widgets/bluesy_widget.dart';

class BluesyToggleSwitch extends BluesyWidget {
  BluesyToggleSwitch(String propertyName) : super(propertyName);

  @override
  Widget build(
    BuildContext context,
    void Function(int newValue) propertyValueSetter,
    int currentValue,
  ) {
    return CupertinoSwitch(
      value: currentValue == 1 ? true : false,
      onChanged: (isSwitchActive) {
        propertyValueSetter(isSwitchActive ? 1 : 0);
      },
    );
  }
}
