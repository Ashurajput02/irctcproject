import 'package:flutter/material.dart';
import 'package:railways1/blue.dart';
import 'package:railways1/homescreen.dart';
import 'package:railways1/splashscreen.dart';

void main() {
  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeScreen(""),
        debugShowCheckedModeBanner: false,
        routes: {
          // '/HomeScreen': (context) => HomeScreen(),
          '/BluetoothScreen': (context) => const BluetoothPage(),
        });
  }
}
