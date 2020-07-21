import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

/// Study screen where lessons are retrieved from the database and posted
///

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
              var documentData = snapshot
                  .data.documents; // All documents in Lessons collection

              // For each, convert them into a Post in a list
              var postList = documentData.map<Post>((doc) {
                var post = Post();
                post.setCreatedOn = doc["createdOn"];
                post.setImageUrl = doc["imageUrl"];
                post.setLikes = doc["likes"];
                post.setOwnerName = doc["ownerName"];
                post.setOwnerUid = doc["ownerUid"];
                post.setPostContents = doc["postContents"];
                return post;
              }).toList();

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
