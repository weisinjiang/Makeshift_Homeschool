import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/study_category_listtile.dart';
import 'package:provider/provider.dart';

/// Study screen where lessons are retrieved from the database and posted
/// The collection "lessons" from Firestore will be passed onto this widget
/// from a Provider outside of the class to prevent the stream from being called
/// multiple times

class StudyScreen extends StatefulWidget {
  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      var postFeedProvider = Provider.of<PostFeedProvider>(context);
      postFeedProvider.fetchPostsFromDatabase(query: "all").then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final feedProvider = Provider.of<PostFeedProvider>(context);
    final top5LikedList = feedProvider.getTop5Likes;
    final top5ViewList = feedProvider.getTop5Viewed;
    final allPosts = feedProvider.getPosts;

    final user = Provider.of<AuthProvider>(context).getUser;
    if (user != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Let's Read! 📖"),
            backgroundColor: kPaleBlue,
            elevation: 0.0,
          ),
          body: _isLoading
              ? LoadingScreen()
              : Container(
                  // entire screen color
                  height: screenSize.height,
                  width: screenSize.width,
                  color: kPaleBlue,
                  // decoration: linearGradientSecondaryGreenAnalogous,
                  child: SingleChildScrollView(
                    // scroll up/down

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StudyCategoryListTile(
                            categoryTitle: "For Your Age", postList: null),
                        StudyCategoryListTile(
                            categoryTitle: "Most Liked",
                            postList: top5LikedList),
                        StudyCategoryListTile(
                            categoryTitle: "Most Viewed",
                            postList: top5ViewList),
                        StudyCategoryListTile(
                            categoryTitle: "All Posts",
                            postList: allPosts),
                      ],
                    ),
                  )));
    } else {
      LoadingScreen();
    }
  }
}
