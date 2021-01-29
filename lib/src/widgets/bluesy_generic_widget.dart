import 'package:bluesy/bluesy.dart';
import 'package:flutter/widgets.dart';

class BluesyGenericWidget extends BluesyWidget {
  /// Name of the widget to register to the Bluesy listener map
  final String name;

  /// The key strings assosciated to this widget
  final List<String> keys;

  final Widget Function(
    BuildContext context,
    void Function(String key, int value) propertyValueSetter,
    Map<String, int> keyValueMap,
  ) builder;

  BluesyGenericWidget({
    @required this.name,
    @required this.keys,
    @required this.builder,
  });

  @override
  Widget build(
    BuildContext context,
    void Function(String key, int value) propertyValueSetter,
    Map<String, int> keyValueMap,
  ) {
    return builder(context, propertyValueSetter, keyValueMap);
  }
}
