import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/database.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';
 
class SearchScreen extends StatefulWidget {
 @override
 _SearchScreenState createState() => _SearchScreenState();
}
 
class _SearchScreenState extends State<SearchScreen> {
 DatabaseMethods databaseMethods = new DatabaseMethods();

 TextEditingController searchTextEditingController =
     new TextEditingController();
 
 QuerySnapshot searchSnapshot;
 
 Widget searchList() {
   return searchSnapshot != null
       ? ListView.builder(
           itemCount: searchSnapshot.docs.length,
           shrinkWrap: true,
           itemBuilder: (context, index) {
             return SearchTile(
               lessonName: searchSnapshot.docs[index].data()["title"],
               lessonAuthor: searchSnapshot.docs[index].data()["ownerName"],
               image: searchSnapshot.docs[index].data()["imageUrl"],
             );
           },
         )
       : Center(
           child: CircularProgressIndicator(),
         );
 }
 
 initiateSearch() {
   //^ Takes what you write in the Search Box and stores it in searchSnapshot
   databaseMethods
       .getLessonByLessonName(searchTextEditingController.text)
       .then((val) {
     setState(() {
       searchSnapshot = val;
     });
   });
 }
 
 @override
 void initState() {
   initiateSearch();
   super.initState();
 }
 
 Widget SearchTile({String lessonName, String lessonAuthor, String image}) {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
     child: Column(
       children: [
         Image.network(image),
         Container(
           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
           child: Row(
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     lessonName,
                     style: mediumTextStyle(),
                   ),
                   Text(
                     "By: ${lessonAuthor}",
                     style: simpleTextStyle(),
                   )
                 ],
               ),
               Spacer(),
               GestureDetector(
                 onTap: () {},
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                   child: Text(
                     "Read",
                     style: simpleTextStyle(),
                   ),
                   decoration: BoxDecoration(
                       gradient: LinearGradient(
                           colors: [Colors.blue[400], Colors.blue[800]]),
                       borderRadius: BorderRadius.circular(30)),
                 ),
               )
             ],
           ),
         )
       ],
     ),
   );
 }
 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black54,
       title: Text(
         "Search for Lessons",
         style: mediumTextStyle(),
       ),
     ),
     body: Column(
       children: [
         Container(
           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
           height: 80,
           color: Color(0x54FFFFFF),
           child: Row(
             children: [
               Expanded(
                 child: TextFormField(
                     controller: searchTextEditingController,
                     style: simpleTextStyle(),
                     decoration: InputDecoration(
                         hintText: "Search lesson name...",
                         hintStyle: TextStyle(color: Colors.white54),
                         border: InputBorder.none)),
               ),
               GestureDetector(
                 onTap: () {
                   initiateSearch();
                 },
                 child: CircleAvatar(
                   backgroundColor: Colors.grey[600],
                   child: Icon(
                     Icons.search,
                     color: Colors.white,
                     size: 30,
                   ),
                 ),
               ),
             ],
           ),
         ),
         searchList()
       ],
     ),
   );
 }
}
