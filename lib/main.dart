import 'package:flutter/material.dart';
import 'package:qibla_app/core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Qibla Pointer",
      home: MyHome(),
    );
  }
}
