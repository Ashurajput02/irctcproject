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
  var isDiscovering = false;
  Timer? _stopScanTimer;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  Future<void> _startDiscovery() async {
    try {
      setState(() {
        isDiscovering = true;
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
        isDiscovering = true;
      });
    });

    // Schedule stop scan after 5 seconds
    _stopScanTimer = Timer(const Duration(seconds: 5), () {
      if (isDiscovering) {
        _stopDiscovery();
        setState(() {
          isDiscovering = false;
        });
      }
    });
  }

  void _stopDiscovery() {
    FlutterBluetoothSerial.instance.cancelDiscovery();
    setState(() {
      isDiscovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: isDiscovering == false ? Colors.white : Colors.grey,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
        actions: [
          TextButton(
            onPressed: () {
              isDiscovering ? null : _startDiscovery();
            },
            child: Text(
              "Refresh",
              style: TextStyle(
                color: isDiscovering == false
                    ? Colors.white
                    : Color.fromARGB(255, 204, 204, 204),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Bluetooth.stopBluetooth();
            },
            child: Text(
              "Disconnect",
              style: TextStyle(
                  color: Bluetooth.isConnected
                      ? Colors.white
                      : Color.fromARGB(255, 208, 207, 207)),
            ),
          )
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
                      // trailing: Text(
                      //   'RSSI: ${device.type}',
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      splashColor: const Color.fromARGB(255, 8, 130, 229),
                      onTap: () async {
                        if (!Bluetooth.isConnected) {
                          // await Bluetooth.connectToDevice(device.address);
                          await BluetoothConnection.toAddress(device.address);
                        }
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
