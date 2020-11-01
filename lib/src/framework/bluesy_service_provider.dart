import 'package:bluesy/bluesy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BluesyServiceProvider extends ChangeNotifierProvider<BluesyService> {
  final Widget child;
  final Widget Function(BuildContext, Widget) builder;

  BluesyServiceProvider({
    @required BluesyService service,
    this.child,
    this.builder,
  }) : super(
          create: (_) => service,
          child: child,
          builder: builder,
        );
}
