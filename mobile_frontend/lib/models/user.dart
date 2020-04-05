import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String id;
  final String username;
  final String email;
  final String photoURL;
  final String displayName;
  final String bio;

  User({
    this.id,
    this.username,
    this.email,
    this.photoURL,
    this.displayName,
    this.bio
  });

  // taking a doc snapshot and turn it into user
  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoURL: doc['photoURL'],
      displayName: doc['displayName'],
      bio: doc['bio'],
    );
  }
}