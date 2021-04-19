import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class StudentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        backgroundColor: Colors.black,
      ),
      body: ListView()
    );
  }
}
