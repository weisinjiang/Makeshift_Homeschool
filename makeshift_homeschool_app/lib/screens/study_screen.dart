import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/color_const.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

/// Study screen where lessons are retrieved from the database and posted
/// The collection "lessons" from Firestore will be passed onto this widget
/// from a Provider outside of the class to prevent the stream from being called
/// multiple times

class StudyScreen extends StatefulWidget {
  final Stream<QuerySnapshot> collectionStream;

  const StudyScreen({Key key, this.collectionStream}) : super(key: key);

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
      Provider.of<PostFeedProvider>(context).fetchPostsFromDatabase().then((_) {
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

    return Scaffold(
        appBar: AppBar(
          title: Text("Let's Read! 📖"),
          backgroundColor: colorPaleGreen,
          elevation: 0.0,
        ),
        body: _isLoading
            ? LoadingScreen()
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [colorPaleGreen, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                      separatorBuilder: (context, int index) => const Divider(),
                      itemCount: postList.length,
                      itemBuilder: (_, index) => ChangeNotifierProvider.value(
                            value: postList[index],
                            child: PostThumbnail(),
                          )),
                )));
  }
}
