# 🟦 Bluesy

**Bluesy** is a Flutter widget library for serial Bluetooth communication between smartphones and microcontrollers. Built on top of [`flutter_bluetooth_serial`](https://pub.dev/packages/flutter_bluetooth_serial), it provides a simplified and widget-driven approach to creating Bluetooth-enabled apps.

![Pub Version](https://img.shields.io/pub/v/bluesy?color=blue)  
[Repository](https://github.com/ernpao/bluesy)

---

## ✨ Features

- Connect to Bluetooth devices with simple UI components
- Send and receive data over serial Bluetooth
- Manage connection states via [Provider](https://pub.dev/packages/provider)
- Designed for use with Arduino, ESP32, and other Bluetooth-capable microcontrollers

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  bluesy: ^0.1.0
```

Then run:
```bash
flutter pub get
```

## 🛠️ Requirements

- Flutter SDK: >=1.17.0 <2.0.0

- Dart SDK: >=2.12.0 <3.0.0

**Note:** flutter_bluetooth_serial only supports Android. This package is Android-only.

## 🚀 Getting Started

```dart
import 'package:bluesy/bluesy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothHomePage(),
    );
  }
}
```

Check the [example](https://github.com/ernpao/bluesy/tree/main/example) directory for a full demo.

## 🧰 Dependencies

- flutter

- provider

- flutter_bluetooth_serial

## 📂 Repository

GitHub: https://github.com/ernpao/bluesy

## 📝 License
MIT
##

Made with 💙 for embedded Bluetooth developers.
