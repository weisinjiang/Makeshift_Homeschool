import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/study_category_listtile.dart';
import 'package:provider/provider.dart';

/// This screen displays video content for MSHM

class StudyVideoScreen extends StatefulWidget {
  @override
  _StudyVideoScreenState createState() => _StudyVideoScreenState();
}

class _StudyVideoScreenState extends State<StudyVideoScreen> {

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
      var videoFeedProvider = Provider.of<VideoFeedProvider>(context);
      videoFeedProvider.fetchVideoPostsFromDatabase().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final feedProvider = Provider.of<VideoFeedProvider>(context);
    final user = Provider.of<AuthProvider>(context).getUser;

    if (user != null) {

      return Scaffold(  
        appBar: AppBar(  
          title: Text("Video Lessons"),
          backgroundColor: kPaleBlue,
          elevation: 0.0,
        ),

        body: _isLoading
          ? LoadingScreen()
          : Container(  
            child: Container(  
              height: screenSize.height,
              width: screenSize.width,
              color: kPaleBlue,
              child: RefreshIndicator(  
                onRefresh: () async {
                  Provider.of<VideoFeedProvider>(context, listen: false).fetchVideoPostsFromDatabase();
                },
                child: SingleChildScrollView(  
                  child: Column(  
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StudyCategoryListTile(
                                categoryTitle: "New Posts",
                                postList: null,
                                videoPostList: null,
                                isVideo: true,
                            ),

                            StudyCategoryListTile(
                                categoryTitle: "Most Bookmarked",
                                videoPostList: feedProvider.getMostBookmarkedPost(5),
                                postList: null,
                                isVideo: true,
                            ),

                            StudyCategoryListTile(
                                categoryTitle: "Most Viewed",
                                postList: null,
                                videoPostList: feedProvider.getMostViewedPost(5),
                                isVideo: true,
                            ),
                            // under 8
                            StudyCategoryListTile(
                                categoryTitle: "Under 8",
                                postList: null,
                                videoPostList: feedProvider.filterPostAgeFrom(
                                  greaterThanAge: true,
                                  targetAge: 8 
                                ),
                                isVideo: true,
                            ),
                            // age 8-9
                            StudyCategoryListTile(
                                categoryTitle: "Age 8 & 9",
                                postList: null,
                                videoPostList: feedProvider.filterPostAgeBetween(
                                  lowerInclusive: 8,
                                  upperInclusive: 9 
                                ),
                                isVideo: true,
                            ),
                            StudyCategoryListTile(
                                categoryTitle: "Age 10 & 11",
                                postList: null,
                                videoPostList: feedProvider.filterPostAgeBetween(
                                  lowerInclusive: 10,
                                  upperInclusive: 11 
                                ),
                                isVideo: true,
                            ),
                            // 12 and Above
                            StudyCategoryListTile(
                                categoryTitle: "Ages 12+",
                                postList: null,
                                videoPostList: feedProvider.filterPostAgeBetween(
                                  lowerInclusive: 12,
                                  upperInclusive: 100
                                ),
                                isVideo: true,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          )
        
        ,

      );

    } else {
      return LoadingScreen();
    }
  }

}