import 'package:flutter/material.dart';

AppBar header({bool isAppTitle = false, String text, bool keepBackButton = true }) {
  return AppBar(
    automaticallyImplyLeading: keepBackButton,
    title: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "LuckiestGuy",
            fontSize: isAppTitle? 40: 25,
            letterSpacing: isAppTitle? 3: 1)),
            centerTitle: true,
  );
}
