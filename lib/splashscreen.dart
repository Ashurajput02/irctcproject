import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:railways1/bluetooth.dart';

class splashscreenfinal extends StatefulWidget {
  @override
  State<splashscreenfinal> createState() => _splashscreenfinalState();
}

class _splashscreenfinalState extends State<splashscreenfinal> {
  @override
  void initState() {
    super.initState();
    Bluetooth.requestPermissions();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/BluetoothScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Align(
          alignment: Alignment.center,
          child: Image.asset("assets/images/raillogo.png"),
        ),
      ),
    );
  }
}
