import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/services/new_video_post_provider.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewVideo extends StatefulWidget {
  final bool isEditing;
  final Post postData;

  const NewVideo({Key key, this.isEditing, this.postData}) : super(key: key);

  @override
  _NewVideoState createState() => _NewVideoState();
}

class _NewVideoState extends State<NewVideo> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<AuthProvider>(context);

    return Provider<NewVideoPostProvider>(
      create: (context) => NewVideoPostProvider(postData: null),
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
                        uid: userInfo.getUserID,
                        name: userInfo.getUserName,
                        userLevel: userInfo.getUserLevel,
                        email: userInfo.getEmail,
                        lessonCreated: userInfo.getLessonCreatedAsInt);

                    Navigator.of(context).pop();
                  }


                  //! To-do...make VideoFeedProvider
                  // //^ Editing and can post
                  // else if (isEditing &&
                  //     newVideoPostProvider.canPost(isEdit: true)) {
                  //   PostFeedProvider provider =
                  //       Provider.of<VideoFeedProvider>(context, listen: false);
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//! Widgets

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white);
}

InputDecoration textFieldInput(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white60),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)));
}
