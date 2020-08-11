import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/widget_constants.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

class UserPosts extends StatefulWidget {
  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
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
      postFeedProvider.fetchPostsFromDatabase(query: "user").then((_) {
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


    return Scaffold(
        appBar: AppBar(
          title: Text("Your Posts"),
        ),
        body: _isLoading ? LoadingScreen() : Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: linearGradientSecondaryGreenAnalogous,
          child: Consumer<PostFeedProvider>(
            /// Consumer for the list because when it is deleted, this widget needs to rebuild
            builder: (context, postFeedProvider, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (_, index) => ChangeNotifierProvider.value(
                                  value: postFeedProvider.getUserPosts[index],
                                  child: PostThumbnail(inUsersProfilePage: true,),
                                ), 
                separatorBuilder: (context, int index) =>
                                const Divider(), 
                itemCount: postFeedProvider.getUserPosts.length
              ),
            ),
          ),
        ));
  }
}
