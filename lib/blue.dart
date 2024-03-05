import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:railways1/bluetooth.dart';
import 'package:railways1/homescreen.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  List<BluetoothDevice> _devicesList = [];
  bool _isDiscovering = false;
  Timer? _stopScanTimer;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  Future<void> _startDiscovery() async {
    try {
      setState(() {
        _isDiscovering = true;
        _devicesList
            .clear(); // Clear the previous list before starting new discovery
      });
      FlutterBluetoothSerial.instance.startDiscovery();
    } catch (ex) {
      print(ex);
    }

    FlutterBluetoothSerial.instance
        .startDiscovery()
        .listen((BluetoothDiscoveryResult state) {
      setState(() {
        _devicesList.add(state.device);
      });
    });

    // Schedule stop scan after 5 seconds
    _stopScanTimer = Timer(const Duration(seconds: 5), () {
      if (_isDiscovering) {
        _stopDiscovery();
      }
    });
  }

  void _stopDiscovery() {
    FlutterBluetoothSerial.instance.cancelDiscovery();
    setState(() {
      _isDiscovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
        actions: [
          ElevatedButton(
            onPressed: _isDiscovering ? null : _startDiscovery,
            child: const Text(
              "Refresh",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(143, 73, 231, 246),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: _devicesList.length,
                  itemBuilder: (context, index) {
                    BluetoothDevice device = _devicesList[index];
                    return ListTile(
                      title: Text(device.name ?? "Unknown"),
                      subtitle: Text(device.address),
                      splashColor: const Color.fromARGB(255, 8, 130, 229),
                      onTap: () async {
                        // await Bluetooth.connectToDevice(device.address);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(device.address)));
                        // await BluetoothConnection.toAddress(device.address);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
