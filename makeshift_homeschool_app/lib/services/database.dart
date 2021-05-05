import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods{
  getLessonByLessonName(String lesson) async {
    return await FirebaseFirestore.instance
        .collection("lessons")
        .where("title", isEqualTo: lesson)
        .get();
  }
}

class DatabaseMethodsVideo{
  getVideoByVideoName(String video) async {
    return await FirebaseFirestore.instance
        .collection("videos")
        .where("title", isEqualTo: video)
        .get();
  }
}