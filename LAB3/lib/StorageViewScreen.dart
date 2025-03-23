import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageViewScreen extends StatefulWidget {
  const StorageViewScreen({Key? key}) : super(key: key);

  @override
  _StorageViewScreenState createState() => _StorageViewScreenState();
}

class _StorageViewScreenState extends State<StorageViewScreen> {
  String storedData = "Loading...";

  @override
  void initState() {
    super.initState();
    _readData();
  }

  Future<void> _readData() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        setState(() {
          storedData = contents;
        });
      } else {
        setState(() {
          storedData = "No data available.";
        });
      }
    } catch (e) {
      setState(() {
        storedData = "Error reading file.";
      });
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stored Data")),
      body: Center(
        child: Text(storedData, style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,),
      ),)
    );
  }
}
