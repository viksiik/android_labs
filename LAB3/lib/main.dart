import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'StorageViewScreen.dart';

void main() {
  runApp(const MaterialApp(
    home: InputScreen(),
  ));
}

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String? selectedShape;
  bool isAreaChecked = false;
  bool isPerimeterChecked = false;
  String selectedFont = 'Montserrat';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _printFilePath() async {
    final path = await _localPath;
    print("Файл зберігається тут: $path/data.txt");
  }


  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<void> _saveData() async {
    final file = await _localFile;
    String data = 'Shape: $selectedShape\n';
    if (isAreaChecked) data += 'Calculate Area\n';
    if (isPerimeterChecked) data += 'Calculate Perimeter\n';
    await file.writeAsString(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved successfully!')),
    );
  }

  void navigateToResult() {
    if (selectedShape == null || (!isAreaChecked && !isPerimeterChecked)) {
      _showAlert();
      return;
    }
    _saveData();
  }

  void _showAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error",
            style: TextStyle(
              fontFamily: selectedFont,
              fontSize: 20,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,)),
        content: Text("Choose shape and at least one parameter to continue.",
            style: TextStyle(
              fontFamily: selectedFont,
              fontSize: 16,
              fontWeight: FontWeight.w400,)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK",
                style: TextStyle(
                  fontFamily: selectedFont,
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,)
            ),
          )
        ],
      ),
    );
  }

  void navigateToStorageView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StorageViewScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE48AFF), Color(0xFF97E9FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFC5C5C5),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            title: Row(
              children: [
                const Icon(Icons.calculate, color: Colors.white),
                const SizedBox(width: 10),
                Text("Objects calculator",
                    style: TextStyle(
                      fontFamily: selectedFont,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,)
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Choose parameters:",
          style: TextStyle(
              fontFamily: selectedFont,
              fontSize: 18,
              fontWeight: FontWeight.w600)
      ),
      CheckboxListTile(
        title: Text("Area",
            style: TextStyle(
                fontFamily: selectedFont,
                fontSize: 18,
                fontWeight: FontWeight.w400)
        ),
        value: isAreaChecked,
        onChanged: (value) {
          setState(() {
            isAreaChecked = value!;
          });
        },
      ),
      CheckboxListTile(
        title: Text("Perimeter",
            style: TextStyle(
                fontFamily: selectedFont,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        value: isPerimeterChecked,
        onChanged: (value) {
          setState(() {
            isPerimeterChecked = value!;
          });
        },
      ),
      const SizedBox(height: 16),

      Text("Choose shape:",
          style: TextStyle(
              fontFamily: selectedFont,
              fontSize: 18,
              fontWeight: FontWeight.w600)
      ),

      Column(
        children: ["Circle", "Square", "Triangle", "Rectangle"].map((shape) {
          return RadioListTile(
            title: Text(shape,
                style: TextStyle(
                    fontFamily: selectedFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)
            ),
            value: shape,
            groupValue: selectedShape,
            onChanged: (value) {
              setState(() {
                selectedShape = value as String?;
              });
            },
          );
        }).toList(),
      ),

      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Щоб кнопки не займали весь простір
          children: [
           ElevatedButton(
                onPressed: navigateToResult,
                child: Text("OK",
                    style: TextStyle(
                        fontFamily: selectedFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
           ),
            const SizedBox(height: 10), // Додати відступ між кнопками
            ElevatedButton(
              onPressed: navigateToStorageView,

              child: Text("Open", style: TextStyle(
                  fontFamily: selectedFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
            ),
            // ElevatedButton(
            //   onPressed: _printFilePath,
            //   child: const Text("Show File Path"),
            // ),

          ],
        ),
      )

          ],
      ),
    ));
  }
}