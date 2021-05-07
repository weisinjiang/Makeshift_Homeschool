import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makeshift_homeschool_app/models/Student_model.dart';
 
class StudentsPageProvider {
 final FirebaseFirestore _database =
     FirebaseFirestore.instance; // connect to firestore
 
 List<Student> studentsList = [];
 
 StudentsPageProvider(String getUserID,
     StudentsPageProvider studentList); // hold all students info
 
 // Get all of the students data
 Future<void> fetchUsers() async {
   QuerySnapshot fetchedData;
   try {
     await _database.collection("users").get();
     // For each user, make a student object
     List<DocumentSnapshot> allUsers = fetchedData.docs;
 
     allUsers.forEach((doc) {
       String uid = doc["uid"];
       String username = doc["username"];
       String profilepicture = doc["imageURL"];
       Student studentObject = Student(
           uid: uid, username: username, profilepicture: profilepicture);
 
       studentsList.add(studentObject); // Add this to the list
     });
   } catch (e) {
     print(e);
   }
 }
}
 
