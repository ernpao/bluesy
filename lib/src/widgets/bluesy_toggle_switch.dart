import 'package:flutter/cupertino.dart';
import '../widgets/bluesy_widget.dart';

class BluesyToggleSwitch extends BluesyWidget {
  final String name;
  BluesyToggleSwitch({
    @required this.name,
    @required String key,
  }) : super(
          name: name,
          keys: [key],
        );

  @override
  Widget build(
    BuildContext context,
    void Function(String key, int value) propertyValueSetter,
    Map<String, int> keyValueMap,
  ) {
    assert(keyValueMap.length == 1);
    final _key = keyValueMap.keys.first;
    final _value = keyValueMap[_key];
    return CupertinoSwitch(
      value: _value == 1 ? true : false,
      onChanged: (isSwitchActive) {
        propertyValueSetter(_key, isSwitchActive ? 1 : 0);
      },
    );
  }
}
