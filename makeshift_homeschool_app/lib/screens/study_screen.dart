import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/widget_constants.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
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
    final postList = Provider.of<PostFeedProvider>(context).getPosts;
    final user = Provider.of<AuthProvider>(context).getUser;
    if (user != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Let's Read! 📖"),
            backgroundColor: kGreenSecondary_analogous2,
            elevation: 0.0,
          ),
          body: _isLoading
              ? LoadingScreen()
              : Container( // entire screen color
                  height: screenSize.height,
                  width: screenSize.width,
                  decoration: linearGradientSecondaryGreenAnalogous,
                  child: SingleChildScrollView( // scroll up/down

                    child: Column(
                      children: [
                        // 
                        Container(
                          alignment: Alignment.topCenter,
                          height: screenSize.height * 0.20,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                                separatorBuilder: (context, int index) =>
                                    const SizedBox(
                                      width: 5,
                                    ),
                                itemCount: postList.length,
                                itemBuilder: (_, index) =>
                                    ChangeNotifierProvider.value(
                                      value: postList[index],
                                      child: PostThumbnail(
                                        inUsersProfilePage: false,
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  )));
    } else {
      LoadingScreen();
    }
  }
}
