import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final userInfo = Provider.of<AuthProvider>(context);

    /// New post uses this provider as a global variable so users can
    /// add as many paragraphs, subtitles as they want.
    return Provider<NewPostProvider>(
      create: (context) => NewPostProvider(postData: postData),
      child: Consumer<NewPostProvider>(
          //Consumes the provider in main.dart
          /// Consumer that uses NewPostProvider
          builder: (context, newPostProvider, _) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black54,
                  title: isEditing
                      ? Text(
                          "Edit Lesson",
                          style: mediumTextStyle(),
                        )
                      : Text("New Lesson",
                          style: mediumTextStyle()),
                  //backgroundColor: kPaleBlue,
                  elevation: 0.0,

                  /// Add to the database
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        // check if the user can post
                        bool canPost = newPostProvider.canPost(isEdit: false);
                        // Not editing
                        if (canPost && !isEditing) {
                          newPostProvider.post(
                              uid: userInfo.getUserID,
                              name: userInfo.getUserName,
                              userLevel: userInfo.getUserLevel,
                              email: userInfo.getEmail,
                              lessonCreated: userInfo.getLessonCreatedAsInt);

                          Navigator.of(context).pop();
                        }

                        /// Editing
                        else if (isEditing &&
                            newPostProvider.canPost(isEdit: true)) {
                          PostFeedProvider provider =
                              Provider.of<PostFeedProvider>(context,
                                  listen: false);

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
                        isEditing ? "Update" : "Post",
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
                  //color: kPaleBlue,
                  height: screenSize.height,
                  width: screenSize.width,
                  // Users can tap anywhere on the screen to exit keyboard
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      height: screenSize.height * 0.85,
                      width: screenSize.width * 0.96,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              /// Get the initial widgetlist
                              children: newPostProvider.getNewPostWidgetList,
                            ),

                            // Raised Button to save as Draft
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RaisedButton(
                                // Make sure the image is loaded

                                onPressed: () {
                                  if (newPostProvider.getNewPostImageFile !=
                                      null) {
                                    newPostProvider.saveDraft(
                                        uid: userInfo.getUserID,
                                        name: userInfo.getUserName,
                                        userLevel: userInfo.getUserLevel,
                                        email: userInfo.getEmail);
                                  } else {
                                    showAlertDialog(
                                        "Upload an image before saving draft",
                                        "Missing Image",
                                        context);
                                  }
                                  Navigator.of(context).pop();
                                },

                                child: Text("Save Draft"),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
    );
  }
}
