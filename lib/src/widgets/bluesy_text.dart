import 'package:flutter/material.dart';
import '../widgets/bluesy_widget.dart';

class BluesyText extends BluesyWidget {
  BluesyText(String propertyName) : super(propertyName);

  @override
  Widget build(
    BuildContext context,
    void Function(int newValue) propertyValueSetter,
    int currentValue,
  ) {
    return Text("$propertyKey: $currentValue");
  }
}
