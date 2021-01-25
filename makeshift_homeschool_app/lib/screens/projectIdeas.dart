import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProjectIdeas extends StatefulWidget {
  @override
  _ProjectIdeasState createState() => _ProjectIdeasState();
}

class _ProjectIdeasState extends State<ProjectIdeas> {
  Widget ActivityTile(
      String content, String title, String image, String author) {
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
                      title,
                      style: mediumTextStyle(),
                    ),
                    Text(
                      "By: ${author}",
                      style: simpleTextStyle(),
                    ),
                    Text(
                      content,
                      style: simpleTextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  QuerySnapshot searchSnapshot;

// Widget searchList() {
//     return searchSnapshot != null
//         ? ListView.builder(
//             itemCount: searchSnapshot.documents.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return ActivityTile(
//                 title: ,
//                 content: ,
//                 image: ,
//                 author: ,
//               );
//             },
//           )
//         : Center(
//             child: CircularProgressIndicator(),
//           );
//   }

  @override
  Widget build(BuildContext context) {
    Map<String, String> userData;
    userData = Provider.of<AuthProvider>(context, listen: false).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: ListView(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
                decoration: BoxDecoration(
                    color: Color(0x54FFFFFF),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none)),
                    TextFormField(
                        maxLines: 10,
                        decoration: InputDecoration(
                            hintText: "What's your activity?",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none)),
                  ],
                )),
            CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.send,
                  color: Colors.blue,
                ))
          ]),
        ));
  }
}
