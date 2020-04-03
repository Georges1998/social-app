import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/widgets/progress.dart';
import '../widgets/header.dart';

final usersRef = Firestore.instance.collection("users");

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    getAdmins();
    super.initState();
  }

  getUserById() async {
    final String id = 'TbJspXTARwXYUoH1yFyw';
    DocumentSnapshot doc = await usersRef.document(id).get();
    print(doc.data);
  }

  getUsers() async {
    QuerySnapshot snapshot = await usersRef.getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }

  getAdmins() async {
    QuerySnapshot snapshot = await usersRef.where("isAdmin", isEqualTo: true).where("postCount", isLessThan: 4).getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(isAppTitle: true, text: "RichieRich"),
    );
  }
}
