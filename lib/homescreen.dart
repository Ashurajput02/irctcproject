import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:railways1/bluetooth.dart';
import 'package:railways1/db.dart';
import 'package:railways1/reportscreen.dart';

class HomeScreen extends StatefulWidget {
  String address = '';
  HomeScreen(this.address);
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();

  bool receiving = true;
  List<int> receivedData = Bluetooth.startListening();

  DatabaseHelper db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 216, 77, 38),
              Color.fromARGB(0, 230, 2, 2)
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 73,
            ),
            Image.asset(
              "assets/images/Indian-Railway.jpg",
              width: double.infinity,
            ),
            const SizedBox(
              height: 31,
            ),
            Expanded(
              child: Container(
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xccffffff),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Sleeper Number:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(),
                          ),
                          child: TextFormField(
                            controller: _name,
                            textAlign: TextAlign.left,
                            decoration: const InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a sleeper number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: Container(
                            width: 140,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(255, 234, 84, 38),
                                  Color.fromARGB(255, 241, 56, 36)
                                  //add more colors
                                ]),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    onSurface: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    //make color or elevated button transparent
                                  ),
                                  onPressed: () async {
                                    print("Start Button Pressed");
                                    List<int> values =
                                        Bluetooth.startListening();
                                    receivedData.addAll(values);
                                    db.insertUserData(
                                        distance: values[0],
                                        gauge: values[1],
                                        elevation: values[2]);
                                    setState(() {
                                      receiving = true;
                                    });
                                  },
                                  child: const Text("START")),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "Distance :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 99,
                            color: CupertinoColors.systemGrey4,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text((receivedData[
                                              receivedData.length -
                                                  index -
                                                  3] ??
                                          0)
                                      .toString()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "Gauge :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 99,
                            color: CupertinoColors.systemGrey4,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text((receivedData[
                                              receivedData.length -
                                                  index -
                                                  2] ??
                                          0)
                                      .toString()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Center(
                        child: Text(
                          "Elevation :",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 99,
                            color: CupertinoColors.systemGrey4,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text((receivedData[
                                              receivedData.length -
                                                  index -
                                                  1] ??
                                          0)
                                      .toString()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Center(
                child: Container(
                  width: 140,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 200, 10, 19),
                          Color.fromARGB(255, 249, 66, 66)
                          //add more colors
                        ]),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          //make color or elevated button transparent
                        ),
                        onPressed: () async {
                          print("Start Button Pressed");
                          setState(() {
                            receiving = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Report(),
                            ),
                          );
                        },
                        child: const Text("STOP")),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
