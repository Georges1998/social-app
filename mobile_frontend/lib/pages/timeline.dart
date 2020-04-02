import 'package:flutter/material.dart';
import 'package:mobile_frontend/widgets/progress.dart';
import '../widgets/header.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(isAppTitle: true, text: "RichieRich"),
      body: linearProgress(),
    );
  }
}
