import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import '../models/videopost_model.dart';


/// This widget shows the video contents: video player, description, author, etc.


class VideoPostExpanded extends StatelessWidget {
  final PostExpandedViewType viewType;
  final VideoPost postData;

  // ViewType Determines how this video will be shown. **Look at shared/enums.dart for more info
  // VideoPost holds data retrived from Firebase
  const VideoPostExpanded({Key key, this.viewType, this.postData}) : super(key: key);

  // Build how the video post should look when a user taps on a thumbnail and the 
  // post gets shown.  NOTE: Skip the video player for now, leave that for Wei.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }}