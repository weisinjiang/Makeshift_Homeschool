import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

class UserVideoPosts extends StatefulWidget {
  @override
  _UserVideoPostsState createState() => _UserVideoPostsState();
}

class _UserVideoPostsState extends State<UserVideoPosts> {
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
      var postFeedProvider = Provider.of<VideoFeedProvider>(context);
      postFeedProvider.fetchUserVideoPostsFromDatabase().then((_) {
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
          title: Text("Your Video Posts"),
        ),
        body: _isLoading
            ? LoadingScreen()
            : Container(
                height: screenSize.height,
                width: screenSize.width,
                color: kPaleBlue,
                //decoration: linearGradientSecondaryGreenAnalogous,
                child: Consumer<VideoFeedProvider>(
                  /// Consumer for the list because when it is deleted, this widget needs to rebuild
                  builder: (context, postFeedProvider, child) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: ListView.separated(
                          itemBuilder: (_, index) => ChangeNotifierProvider.value(
                                value: postFeedProvider.getUsersVideoPosts[index],
                                child: PostThumbnail(
                                  viewType: PostExpandedViewType.owner,
                                  isVideo: true,
                                
                                ),
                              ),
                          separatorBuilder: (context, int index) =>
                              const Divider(),
                          itemCount: postFeedProvider.getUsersVideoPosts.length == null ? 0: postFeedProvider.getUsersVideoPosts.length),
                    ),
                  ),
                ),
              ));
  }
}