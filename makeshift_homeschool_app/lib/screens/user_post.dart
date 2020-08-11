import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
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
      Provider.of<PostFeedProvider>(context)
          .fetchUserPostsFromDatabase()
          .then((_) {
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
    List<Post> usersPosts = Provider.of<PostFeedProvider>(context).getUserPosts;

    return Scaffold(
        appBar: AppBar(
          title: Text("Your Posts"),
        ),
        body: _isLoading ? LoadingScreen() : Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: linearGradientSecondaryGreenAnalogous,
          child: ListView.separated(
            itemBuilder: (_, index) => ChangeNotifierProvider.value(
                              value: usersPosts[index],
                              child: PostThumbnail(),
                            ), 
            separatorBuilder: (context, int index) =>
                            const Divider(), 
            itemCount: usersPosts.length
          ),
        ));
  }
}
