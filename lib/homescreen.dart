import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:railways1/reportscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();

  bool receiving = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff302d7d), Color(0x00ffffff)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 73,
            ),
            Image.asset(
              "assets/images/irctc.png",
              width: 100,
              height: 122,
            ),
            SizedBox(
              height: 31,
            ),
            Expanded(
              child: Container(
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xccffffff),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 48),
                      Padding(
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
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(),
                          ),
                          child: TextFormField(
                            controller: _name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
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
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Center(
                          child: Container(
                            width: 140,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xff302d7d), Color(0xff5c5a93)
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
                                    setState(() {
                                      receiving = true;
                                    });
                                  },
                                  child: Text("START")),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
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
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 99,
                            color: CupertinoColors.systemGrey4,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Item $index"),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
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
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 99,
                            color: CupertinoColors.systemGrey4,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Item $index"),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
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
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 99,
                            color: CupertinoColors.systemGrey4,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Item $index"),
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
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Container(
                  width: 140,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff302d7d), Color(0xff5c5a93)
                          //add more colors
                        ]),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: <BoxShadow>[
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
                        child: Text("STOP")),
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
