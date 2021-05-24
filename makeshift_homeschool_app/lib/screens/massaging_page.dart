import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/profile_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/message_form.dart';

import 'package:makeshift_homeschool_app/widgets/message_wall.dart';
import 'package:provider/provider.dart';

class MassagingPage extends StatefulWidget {
  final store = FirebaseFirestore.instance.collection("chat_messages");

  @override
  _MassagingPageState createState() => _MassagingPageState();
}

class _MassagingPageState extends State<MassagingPage> {
  void _addMessages(String value) async {
    final Map<String, dynamic> userInfo =
        Provider.of<AuthProvider>(context, listen: false).getUserInfo;

    await widget.store.add({
      "author_username": userInfo["studentFirstName"],
      "author_image": userInfo["photoURL"],
      "author_uid": userInfo["uid"],
      "timestamp": Timestamp.now().millisecondsSinceEpoch,
      "value": value
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userInfo =
        Provider.of<AuthProvider>(context, listen: false).getUserInfo;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("Join The Conversation!",
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, SlideLeftRoute(screen: ProfileScreen()));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userInfo["photoURL"],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.store.orderBy("timestamp").snapshots(),
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
          MessageForm(onSubmit: _addMessages)
        ],
      ),
    );
  }
}
