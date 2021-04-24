import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

QuerySnapshot studentSnapshot;

class StudentsPage extends StatefulWidget {
  //^ Make StudentProvider (see post_feed_provider.dart)

  //^ add didChangeDepandancies and init
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Students"),
          backgroundColor: Colors.black,
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: [],
        ));
  }
}
