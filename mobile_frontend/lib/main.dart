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
      theme: ThemeData(accentColor: Color(0xff294a66), primaryColor: Color(0xff364f6b)),
      home: Home(),
    );
  }
}
