import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessageOther extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;

  

  const ChatMessageOther({Key key, this.index, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(  
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userInfo["photoURL"]),
          )
        ],
      ),
    );
  }
}
