import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:railways1/db.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/indianrailways.png",
            width: 199,
            height: 243,
            color: Color.fromRGBO(
                255, 255, 255, 0.19), // Adjust the opacity (0.0 to 1.0)
            colorBlendMode: BlendMode.modulate,
          ),
          Center(
            child: Positioned(
              top: 0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // primary: Colors.transparent,
                  elevation: 3,
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () async {
                  await _generateAndDownloadCSV(context);
                  // Add your functionality for the button here
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DatabaseTable()));
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAndDownloadCSV(BuildContext context) async {
    // Retrieve all user data from SQLite database
    List<Map<String, dynamic>> userDataList =
        await DatabaseHelper().getAllUserData();

    List<String> header = [
      'Gauge',
      'Distance',
      'Elevation',
    ];

    // Generate CSV data for new entries only
    List<List<String>> newCsvData = [];
    for (var userData in userDataList) {
      newCsvData.add([
        userData['Gauge'],
        userData['Distance'].toString(),
        userData['Elevation'].toString(),
      ]);
    }

    // Get the path to the existing CSV file
    // Directory? downloadsDir = await getExternalStorageDirectory();
    // String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    // String filePath = '${downloadsDir!.path}/Report_$timestamp.csv';

    // Get the app's documents directory

    Directory documentsDir = await getApplicationDocumentsDirectory();
    // String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String timestamp = (DateTime.now()).toString();
    print("timestamp: $timestamp");

    String filePath = '${documentsDir.path}/Report_$timestamp.csv';
    print("DIrecturyyyy: $documentsDir");
    print("filleee pathhh: $filePath");

    try {
      // Check if the file exists
      bool fileExists = await File(filePath).exists();

      if (fileExists) {
        // Read existing CSV data
        String existingCsvContent = await File(filePath).readAsString();
        List<List<dynamic>> existingCsvData =
            CsvToListConverter().convert(existingCsvContent);

        // Combine existing and new data
        existingCsvData.addAll(newCsvData);

        // Write CSV data with header
        await File(filePath).writeAsString(
          const ListToCsvConverter(fieldDelimiter: '  ')
              .convert(existingCsvData),
          encoding: utf8,
        );
      } else {
        // Write CSV data with header
        await File(filePath).writeAsString(
          const ListToCsvConverter(fieldDelimiter: '  ')
              .convert([header] + newCsvData),
          encoding: utf8,
        );
      }

      String documentsFolderPath = '/storage/emulated/0/Documents';
      Directory? externalDir = await getExternalStorageDirectory();
      // String newFilePath = '${externalDir!.path}/Report_$timestamp.csv';
      // Generate a timestamp for the filename

      // Create a filename with the prefix "Report" + date and time
      String fileName = 'Report_$timestamp.csv';

      String newFilePath = '$documentsFolderPath/$fileName';

      await File(filePath).copy(newFilePath);
      print("neww file pathh: $newFilePath");
      await File(filePath).delete();

      // Show success message and open option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Report saved to Documents!'),
          // action: SnackBarAction(
          //   label: 'Open',
          //   onPressed: () async {
          //     // OpenFile.open(newFilePath);
          //     await OpenAppFile.open(newFilePath, mimeType: 'text/csv', uti: 'public.comma-separated-values-text', locate: false);
          //     print("opened!!!");
          //   },
          // ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Saving!'),
          // action: SnackBarAction(
          //   label: 'Open',
          //   onPressed: () async {
          //     // OpenFile.open(newFilePath);
          //     await OpenAppFile.open(newFilePath, mimeType: 'text/csv', uti: 'public.comma-separated-values-text', locate: false);
          //     print("opened!!!");
          //   },
          // ),
        ),
      );
      print("Error saving CSV: $e");
      // Handle the error and inform the user
    }
  }
}
