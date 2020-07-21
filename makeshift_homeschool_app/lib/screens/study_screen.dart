import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail_grid.dart';
import 'package:provider/provider.dart';

/// Study screen where lessons are retrieved from the database and posted
///

class StudyPage extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  var _isInThisWidget = true;
  var _isLoadingPostThumbnails = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInThisWidget) {
      setState(() {
        _isLoadingPostThumbnails = true;
      });
      Provider.of<PostFeedProvider>(context).getPostsFromDatabase().then((_) {
        setState(() {
          _isLoadingPostThumbnails = false;
        });
      });
    }
    _isInThisWidget = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
      ),
      body: _isLoadingPostThumbnails ? LoadingScreen() : PostThumbnailGrid(),
    );
  }
}
