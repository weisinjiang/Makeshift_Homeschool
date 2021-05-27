import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/database.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';
 
//!..TODO fix this search screen (doesn't work)

class SearchVideosScreen extends StatefulWidget {
 @override
 _SearchVideosScreenState createState() => _SearchVideosScreenState();
}
 
class _SearchVideosScreenState extends State<SearchVideosScreen> {
 DatabaseMethodsVideo databaseMethodsVideo = new DatabaseMethodsVideo();

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
               videoName: searchSnapshot.docs[index].data()["title"],
               videoAuthor: searchSnapshot.docs[index].data()["ownerName"],
             );
           },
         )
       : Center(
           child: CircularProgressIndicator(),
         );
 }
 
 initiateSearch() {
   //^ Takes what you write in the Search Box and stores it in searchSnapshot
   databaseMethodsVideo
       .getVideoByVideoName(searchTextEditingController.text)
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
 
 Widget SearchTile({String videoName, String videoAuthor}) {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
     child: Column(
       children: [
         Container(
           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
           child: Row(
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     videoName,
                     style: mediumTextStyle(),
                   ),
                   Text(
                     "By: ${videoAuthor}",
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
                     "Watch",
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
         "Search for Videos",
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
                     style: TextStyle(color: Colors.black),
                     decoration: InputDecoration(
                         hintText: "Search video name...",
                         hintStyle: TextStyle(color: Colors.black54),
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
