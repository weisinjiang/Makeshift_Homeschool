import 'package:flutter/material.dart';
import 'dart:core';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';

/// Expanded Post after clicking on a Post Thumbnail.
/// Enlarged so you can see all the details for the post
///
class PostExpanded extends StatelessWidget {
  final Post postData;

  const PostExpanded({Key key, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
  
    return Scaffold(
      appBar: AppBar(
        title: Text(postData.getTitle),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: ListView(
          children: postData.getPostWidgetList(screenSize),
        ),
      ),
    );
  }
}
