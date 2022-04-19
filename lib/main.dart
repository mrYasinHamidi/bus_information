import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/pages/HomePage.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  Future init() async {
    await DatabaseHelper.instance.init();
  }

  runApp(
    FutureBuilder(
      future: init(),
      builder: (context, snapShot) {
        if (snapShot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(),
          );
        }
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Languages.language,
      builder: (BuildContext context, Languages value, Widget? child) {
        return MaterialApp(
          builder: (context, child) {
            return Directionality(
              textDirection: Languages.language.value.direction,
              child: child ?? const Scaffold(),
            );
          },
          theme: ThemeData(fontFamily: 'iranSans'),
          title: Languages.language.value.appName,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}

