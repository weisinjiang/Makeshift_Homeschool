import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';

import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';


/// Study screen where lessons are retrieved from the database and posted
/// The collection "lessons" from Firestore will be passed onto this widget
/// from a Provider outside of the class to prevent the stream from being called
/// multiple times

class StudyPage extends StatelessWidget {
  final Stream<QuerySnapshot> collectionStream;

  const StudyPage({Key key, this.collectionStream}) : super(key: key);
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
      ),
      body: StreamBuilder(
          stream: collectionStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // contains every document in Lessons
              var documentData = snapshot.data.documents;

              /// Convert the query snapshot from the database into a list of
              /// posts by assigning values into a Post object
              var postList = documentData.map<Post>((doc) {
                var post = Post();
                post.setCreatedOn = doc["createdOn"];
                post.setImageUrl = doc["imageUrl"];
                post.setLikes = doc["likes"];
                post.setOwnerName = doc["ownerName"];
                post.setOwnerUid = doc["ownerUid"];
                post.setTitle = doc["title"];
                post.setPostContents = doc["postContents"];
                return post;
              }).toList();
              print("POST LIST");
              print(postList[0].getTitle);

              /// Show it
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: screenSize.height * 0.05,
                        crossAxisSpacing: screenSize.width * 0.05),
                    itemCount: postList.length,
                    itemBuilder: (_, index) =>
                        PostThumbnail(postData: postList[index])),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return LoadingScreen();
          }),
    );
  }
}
