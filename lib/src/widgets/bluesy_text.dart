import 'package:flutter/material.dart';
import '../widgets/bluesy_widget.dart';

class BluesyText extends BluesyWidget {
  final String _widgetName;

  BluesyText(
    this._widgetName,
  );

  @override
  String get widgetName => _widgetName;

  @override
  Widget build(BuildContext context,
      void Function(int newValue) setValueCallback, int currentValue) {
    return Text("$widgetName: $currentValue");
  }
}
