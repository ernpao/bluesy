import 'package:flutter/material.dart';
import '../widgets/bluesy_widget.dart';

class BluesyText extends BluesyWidget {
  final String name;

  /// The size of glyphs (in logical pixels) to use when painting the text.
  final double? fontSize;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The typeface variant to use when drawing the letters (e.g., italics).
  final FontStyle? fontStyle;

  /// The typeface thickness to use when painting the text (e.g., bold).
  final FontWeight? fontWeight;

  /// The color to use when painting the text.
  final Color? color;
  BluesyText({
    required this.name,
    required String key,
    this.fontSize,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.fontStyle,
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
    assert(!(keyValueMap.length < 1));
    final _key = keyValueMap.keys.first;
    final _value = keyValueMap[_key];
    return Text(
      "$name: $_value",
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
