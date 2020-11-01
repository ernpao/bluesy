import 'package:bluesy/bluesy.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BluesyServiceProvider extends ChangeNotifierProvider<BluesyService> {
  BluesyServiceProvider({@required BluesyService service})
      : super(
          create: (_) => service,
        );
}
