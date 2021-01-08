import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods{
  getLessonByLessonName(String lesson) async {
    return await Firestore.instance
        .collection("lessons")
        .where("title", isEqualTo: lesson)
        .getDocuments();
  }
}