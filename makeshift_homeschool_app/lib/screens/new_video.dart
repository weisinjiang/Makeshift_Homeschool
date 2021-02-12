import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_video_post_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class NewVideo extends StatelessWidget {
  final bool isEditing;
  final VideoPost postData;

  const NewVideo({Key key, this.isEditing, this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final userInfo = Provider.of<AuthProvider>(context);

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

                  else {
                    showAlertDialog("One or more of your fields are empty",
                        "ERROR", context);
                  }
                },
                child: Text(isEditing ? "Update" : "Post", style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),),
                highlightColor: Colors.transparent,
                color: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ],
          ),
          body: Container(  
            color: Colors.black,
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
