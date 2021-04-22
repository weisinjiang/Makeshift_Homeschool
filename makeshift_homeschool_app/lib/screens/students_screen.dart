import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

QuerySnapshot studentSnapshot;

class StudentsPage extends StatelessWidget {
  Widget studentList() {
    return studentSnapshot != null
        ? ListView.builder(
            itemCount: studentSnapshot.docs.length,
            itemBuilder: (context, index) {
              return StudentObject(
                uid: studentSnapshot.docs[index].data()["uid"],
                username: studentSnapshot.docs[index].data()["username"],
                profilepicture: studentSnapshot.docs[index].data()["photoURL"],
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget StudentObject({
    String uid,
    String username,
    String profilepicture,
  }) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Image.network(profilepicture),
            Text(username),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        backgroundColor: Colors.black,
      ),
      body: studentList(),

    );
  }
}
