import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/widgets/popup_appbar.dart';
import '../models/videopost_model.dart';

/// This widget shows the video contents: video player, description, author, etc.

class VideoPostExpanded extends StatelessWidget {
  final PostExpandedViewType viewType;
  final VideoPost videoPostData;

  // ViewType Determines how this video will be shown. **Look at shared/enums.dart for more info
  // VideoPost holds data retrived from Firebase
  const VideoPostExpanded({Key key, this.viewType, this.videoPostData})
      : super(key: key);

  // Build how the video post should look when a user taps on a thumbnail and the
  // post gets shown.  NOTE: Skip the video player for now, leave that for Wei.
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PopupMenuAppBar(
        // postData: videoPostData,
        screenSize: screenSize,
        appBar: AppBar(),
        canDelete: viewType == PostExpandedViewType.owner ? true : false,
      ),
      body: Container(  
        width: screenSize.width,
        height: screenSize.height,
        alignment: Alignment.topCenter,
        child: Container(  
          width: kIsWeb 
            ? screenSize.width * 0.50
            : screenSize.width,
          height: screenSize.height,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(  
            child: Column(  
              children: [
                Column(
                  // children: videoPostData.con,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
