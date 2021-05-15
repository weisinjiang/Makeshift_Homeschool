import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/message_form.dart';

import 'package:makeshift_homeschool_app/widgets/message_wall.dart';

class MassagingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("Join The Conversation!",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chat_messages")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MessageWall(
                    messages: snapshot.data.docs,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          MessageForm(
            onSubmit: (value) {
              print("==>" + value);
            },
          )
        ],
      ),
    );
  }
}
