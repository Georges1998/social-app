import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String merdiaUrl;
  final dynamic likes;
  final String price;

  Post({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.merdiaUrl,
    this.likes,
    this.price,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      description: doc['description'],
      merdiaUrl: doc['merdiaUrl'],
      likes: doc['likes'],
      price: doc['price'],
    );
  }

  int getLikeCount(likes) {
    if (likes == null) {
      return 0;
    } else {
      int count = 0;
      likes.values.forEach((val) {
        if (val == true) {
          count += 1;
        }
      });
      return count;
    }
  }

  @override
  _PostState createState() => _PostState(
        postId: this.postId,
        ownerId: this.ownerId,
        username: this.username,
        location: this.location,
        description: this.description,
        merdiaUrl: this.merdiaUrl,
        likes: this.likes,
        likeCount: getLikeCount(this.likes),
        price: this.price,
      );
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String merdiaUrl;
  int likeCount;
  Map likes;
  final String price;

  _PostState({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.merdiaUrl,
    this.likes,
    this.likeCount,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Post");
  }
}
