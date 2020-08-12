import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:makeshift_homeschool_app/shared/widget_constants.dart';
import 'package:provider/provider.dart';

///  Pops up a form for users to create a lesson
/// Takes a lesson name and multiple subtitles and paragraphs
/// Users will be able to add additional paragraphs and subtiltes, but there
/// can only be 1 title.
///
/// Structure
///   Form takes in a list of cutomized TextFormField widgets
///   Adding a new subtitle or paragraph adds these cutomized widgets into
///   the list and redraws the screen.
///
///   A form key is provided to keep track of the contents in the forms when
///   a new paragraph or subtitle is added
///
/// @param isEditing - If the user is editing the post or not

class NewPostScreen extends StatelessWidget {
  final isEditing;
  final Post postData;

  const NewPostScreen({Key key, this.isEditing, this.postData})
      : super(key: key);

  /// Added widgets are in-order and will be placed into Firestore the same way
  /// Widget index should be the same as the order in which it appears on the
  /// app from top to bottom: index 0 = first item on the screen
  //NewPostProvider newPost = NewPostProvider();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var userInfo = Provider.of<AuthProvider>(context).getUser;

    /// New post uses this provider as a global variable so users can
    /// add as many paragraphs, subtitles as they want.
    return Provider<NewPostProvider>(
      create: (context) => NewPostProvider(),
      child: Consumer<NewPostProvider>(
          //Consumes the provider in main.dart
          /// Consumer that uses NewPostProvider
          builder: (context, newPostProvider, _) {
        if (isEditing) {
          newPostProvider.setEditingData(postData);
        }
        return Scaffold(
          appBar: AppBar(
            title: isEditing ? Text("Edit Lesson") : Text("New Lesson"),
            elevation: 1.0,
            backgroundColor: kGreenSecondary_analogous2,

            /// Add to the database
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  // new post and not editing
                  if (newPostProvider.canPost(isEdit: false) && !isEditing) {
                    ///! Change so that it gets info from the local value!!!!!
                    int lessonCreated = int.parse(userInfo["lesson_created"]);
                    newPostProvider.post(
                        userInfo["uid"], userInfo["username"], lessonCreated);

                    Navigator.of(context).pop();
                  }

                  /// Editing
                  else if (isEditing && newPostProvider.canPost(isEdit: true)) {
                    PostFeedProvider provider =
                        Provider.of<PostFeedProvider>(context, listen: false);

                    /// Pass in the post feed provider so the post can be updated
                    newPostProvider.update(postData, provider);
                    // pop the update screen
                    Navigator.of(context).pop();
                  } else {
                    showAlertDialog(
                        "One or more of your fields are empty. Please fill them in, or remove paragraphs/subtitles that you are not using.",
                        "ERROR",
                        context);
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                highlightColor: Colors.transparent,
                color: Colors.transparent,
                splashColor: Colors.transparent,
              )
            ],
          ),
          // used to add paragraphs, images and titles

          /// Using a builder because a scaffold is shown in one of the child widgets below
          /// Scaffold of above is not reachable without the Builder widget.
          body: Container(
            /// Color of the entire background of this page
            decoration: linearGradientSecondaryGreenAnalogous,
            height: screenHeight,
            width: screenWidth,

            /// Users can add infinite amount of subtiles and paragraphs, so when
            /// it goes out of screen, it should be scrollable
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: screenHeight * 0.85,
                width: screenWidth * 0.96,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    /// Get the initial widgetlist
                    children: newPostProvider.getNewPostWidgetList,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
