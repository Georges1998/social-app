import 'package:flutter/material.dart';
import 'package:mobile_frontend/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
