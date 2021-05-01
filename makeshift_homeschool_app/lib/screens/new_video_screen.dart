import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_video_post_provider.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class NewVideoPostScreen extends StatelessWidget {
  final bool isEditing;
  final VideoPost postData;

  const NewVideoPostScreen({Key key, this.isEditing, this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final userInfo = Provider.of<AuthProvider>(context).getUserInfo;

    return Provider<NewVideoPostProvider>(
      create: (context) => NewVideoPostProvider(postData: postData),
      child: Consumer<NewVideoPostProvider>(
        builder: (context, newVideoPostProvider, _) => Scaffold(
          appBar: AppBar(
            title: isEditing
                ? Text(
                    "Edit Lesson",
                    style: TextStyle(color: Colors.black),
                  )
                : Text(
                    "New Lesson",
                    style: TextStyle(color: Colors.black),
                  ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  bool canPost = newVideoPostProvider.canPost(isEdit: false);
              

                  //^ Not editing and can post
                  if (canPost && !isEditing) {
                    newVideoPostProvider.post(
                        uid: userInfo["uid"],
                        name: userInfo["studentFirstName"],
                        userLevel: userInfo["level"], 
                        email: userInfo["studentEmail"],
                        lessonCreated: userInfo["lessonCreated"]);

                    Navigator.of(context).pop();
                  }

                 
                  /// Editing and can post
                  else if (isEditing && newVideoPostProvider.canPost(isEdit: true)) {
                    VideoFeedProvider provider = Provider.of<VideoFeedProvider>(context,listen: false);

                    /// Pass in the post feed provider so the post can be updated
                    newVideoPostProvider.update(postData: postData, provider:provider);
                    // pop the update screen
                    Navigator.of(context).pop();

                  } 

                  else {
                    showAlertDialog("One or more of your fields are empty",
                        "ERROR", context);
                  }
                },
                child: Text(
                  isEditing ? "Update" : "Post",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                highlightColor: Colors.transparent,
                color: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ],
          ),
          body: Container(
            color: kPaleBlue,
            alignment: Alignment.topCenter,
            child: Container(
              width: kIsWeb ? screenSize.width * 0.50 : screenSize.width,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: newVideoPostProvider.getNewVideoWidgetList,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


