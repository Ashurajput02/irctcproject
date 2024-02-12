import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/raillogo.png",
              width: 199,
              height: 243,
              color: const Color.fromRGBO(
                  255, 255, 255, 0.8), // Adjust the opacity (0.0 to 1.0)
              colorBlendMode: BlendMode.modulate,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // primary: Colors.transparent,
                  elevation: 1,
                  backgroundColor: Colors.deepOrange,
                  fixedSize: const Size(170, 65),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              onPressed: () {
                // Add your functionality for the button here
                print("Generate Report Button Pressed");
              },
              child: const Text(
                "Generate Report",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
