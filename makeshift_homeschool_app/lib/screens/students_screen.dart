import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/student_page_provider.dart';
import 'package:provider/provider.dart';
 
QuerySnapshot studentSnapshot;
 
class StudentsPage extends StatefulWidget {
 //^ Make StudentProvider (see post_feed_provider.dart)
 
 
 @override
 _StudentsPageState createState() => _StudentsPageState();
}
 
class _StudentsPageState extends State<StudentsPage> {
 var _isInit = true;
 var _isLoading = false;
 
 
 //^ didChangeDependancies
 @override
 void didChangeDependencies() {
   if (_isInit) {
     setState(() {
       _isLoading = true;
     });
     // fetch all posts
     var studentProvider = Provider.of<StudentsPageProvider>(context);
     studentProvider.fetchUsers().then((_) {
       setState(() {
         _isLoading = false;
       });
     });
   }
   _isInit = false;
   super.didChangeDependencies();
 }
 
 
 
 
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
