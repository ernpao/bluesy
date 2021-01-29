import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../framework/bluesy_service.dart';

abstract class BluesyWidget extends StatefulWidget {
  /// Name of the widget to register to the Bluesy listener map
  final String name;

  /// The key strings assosciated to this widget
  final List<String> keys;

  BluesyWidget({
    @required this.name,
    @required this.keys,
  });

  @override
  _BluesyWidgetState createState() => _BluesyWidgetState();

  /// Builder method for a Bluesy widget. You can pass an integer to
  /// the [propertyValueSetter] function provided. Doing so will send a key-value pair
  /// message to the paired bluetooth device, with the key being the [keys]
  /// string of the Bluesy widget.

  Widget build(
    BuildContext context,
    void Function(String key, int value) propertyValueSetter,
    Map<String, int> keyValueMap,
  );
}

class _BluesyWidgetState extends State<BluesyWidget> {
  Map<String, int> _keyValueMap;
  BluesyService _bluetoothService;

  @override
  void initState() {
    _keyValueMap = {};
    widget.keys.forEach((_key) {
      print(_key);
      _keyValueMap[_key] = 0;
    });
    super.initState();
  }

  void _setPropertyValue(String key, int value) {
    _bluetoothService.send("$key,$value;");
    setState(() {
      _keyValueMap[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    _bluetoothService = Provider.of<BluesyService>(context);
    _bluetoothService.addBluetoothListener(widget.name, (message) {
      int commaPos = message.indexOf(",");
      String key = message.substring(0, commaPos);

      if (widget.keys.contains(key)) {
        int delimiterPos = message.lastIndexOf(";");
        String valueStr = message.substring(commaPos + 1, delimiterPos);
        int value = int.parse(valueStr);
        setState(() {
          _keyValueMap[key] = value;
        });
      }
    });
    return widget.build(context, _setPropertyValue, _keyValueMap);
  }
}
