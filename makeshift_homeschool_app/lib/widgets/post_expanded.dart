import 'package:flutter/material.dart';
import 'dart:core';
import 'package:makeshift_homeschool_app/models/post_model.dart';

/// Expanded Post after clicking on a Post Thumbnail.
/// Enlarged so you can see all the details for the post
/// Post has a method called constructPostWidgetListthat makes the widget list
/// to be displayed in ListView
class PostExpanded extends StatelessWidget {
  final Post postData; /// post data passed from PostThumbnail

  const PostExpanded({Key key, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
  
    return Scaffold(
      appBar: AppBar(
        title: Text(postData.getTitle), /// get the title
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: ListView(
          children: postData.constructPostWidgetList(screenSize), /// make list
        ),
      ),
    );
  }
}
