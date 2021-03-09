import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsPageProvider {
  final FirebaseFirestore _database =
      FirebaseFirestore.instance; // connect to firestore

  Future<void> fetchUsers() async {
    try {
      await _database
          .collection("users")
          .where("uid")
          .where("photoURL")
          .where("username")
          .get();
    } catch (e) {
      print(e);
    }
  }
}
