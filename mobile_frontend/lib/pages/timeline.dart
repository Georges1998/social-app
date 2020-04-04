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
    deleteUser();
    super.initState();
  }

  createUser() async {
    usersRef
        .document("abcdef123")
        .setData({"username": "Jeff", "postCount": 0, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.document("abcdef123").get();
    if (doc.exists) {
      doc.reference
          .updateData({"username": "Jeff", "postCount": 0, "isAdmin": false});
    }
  }

  deleteUser() async {
    final doc = await usersRef.document("abcdef123").get();
    if (doc.exists) {
      doc.reference.delete();
    }else{
      print("Doc does not exist");
    }
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
    QuerySnapshot snapshot = await usersRef
        .where("isAdmin", isEqualTo: true)
        .where("postCount", isLessThan: 4)
        .getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(isAppTitle: true, text: "RichieRich"),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          } else {
            final List<Text> children = snapshot.data.documents
                .map((doc) => Text(doc['username']))
                .toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          }
        },
      ),
    );
  }
}
