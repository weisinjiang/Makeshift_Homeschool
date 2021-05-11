import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageWall extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;

  const MessageWall({Key key, this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(messages[index].data()["value"], style: TextStyle(color: Colors.white),),
        );
      },
    );
  }
}
