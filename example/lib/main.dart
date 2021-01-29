import 'package:bluesy/bluesy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BluesySampleApp());
}

class BluesySampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluesy Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: BluesyServiceProvider(
        service: BluesyGenericService("HC-05 JSON Test"),
        builder: (BuildContext context, Widget child) {
          final bluesy = Provider.of<BluesyService>(context);
          if (!bluesy.isConnected) {
            if (bluesy.isConnecting) {
              return _LoadingScreen();
            }
            return _ConnectScreen();
          } else {
            return _BluesyWidgetsDemoScreen();
          }
        },
      )),
    );
  }
}

class _BluesyWidgetsDemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: SizedBox(
            width: 300,
            child: BluesyText(
              name: "Bluesy Text Widget Sample",
              key: "Text",
              fontSize: 24,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _DisconnectSection(),
      ],
    );
  }
}

class _DisconnectSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bluesy = Provider.of<BluesyService>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: RaisedButton(
              child: Text("Disconnect"),
              onPressed: () {
                bluesy.disconnect();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Disconnect from HC-05",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ConnectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bluesy = Provider.of<BluesyService>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: RaisedButton(
              child: Text("Connect"),
              onPressed: () {
                bluesy.connect();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Connect to HC-05",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Connecting to HC-05",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
