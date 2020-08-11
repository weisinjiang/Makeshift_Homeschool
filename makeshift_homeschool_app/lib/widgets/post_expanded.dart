import 'package:flutter/material.dart';
import 'dart:core';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'can_edit_post_app_bar.dart';

/// Expanded Post after clicking on a Post Thumbnail.
/// Enlarged so you can see all the details for the post
/// Post has a method called constructPostWidgetListthat makes the widget list
/// to be displayed in ListView
class PostExpanded extends StatelessWidget {
  final bool canDelete;

  /// if in user's profile, they can delete the post
  final Post postData;

  /// post data passed from PostThumbnail

  const PostExpanded({Key key, this.postData, this.canDelete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: canDelete
          ? CanEditPostAppBar(postData: postData, screenSize: screenSize)
          : AppBar(
              title: Text(postData.getTitle),

              /// get the title
            ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: postData.constructPostWidgetList(screenSize),

            /// make list
          ),
        ),
      ),
    );
  }
}


