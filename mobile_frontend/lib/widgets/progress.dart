import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Color(0xff364f6b)),
    ),
  );
}

linearProgress() {
  return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Color(0xff364f6b)),
      ));
}
