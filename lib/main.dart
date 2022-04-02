import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async{
  Hive.init(Directory.current.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
