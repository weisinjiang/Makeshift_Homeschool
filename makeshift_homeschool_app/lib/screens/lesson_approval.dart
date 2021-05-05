import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

/*
  UI for Principle to review posts made by Tutors before passing it onto 
  Teachers for Review
*/

class LessonApprovalScreen extends StatefulWidget {
  final Reviewer reviewer;

  const LessonApprovalScreen({Key key, this.reviewer}) : super(key: key);
  @override
  _LessonApprovalScreenState createState() => _LessonApprovalScreenState();
}

class _LessonApprovalScreenState extends State<LessonApprovalScreen> {
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
      postFeedProvider.fetchInReviewPosts(widget.reviewer).then((_) {
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
    final userInfo = Provider.of<AuthProvider>(context).getUserInfo;
    final postList = Provider.of<PostFeedProvider>(context).getApprovalNeeded;
    final screenSize = MediaQuery.of(context).size;

    if (userInfo != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Review Tutor Lessons"),
            backgroundColor: kPaleBlue,
          ),
          body: _isLoading
              ? LoadingScreen()
              : Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: kPaleBlue,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Provider.of<PostFeedProvider>(context, listen: false)
                          .fetchInReviewPosts(widget.reviewer);
                    },
                    child: postList.length == 0 ? Center(child: Text("No Lessons to review...")):
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                      separatorBuilder: (context, int index) => const Divider(),
                      itemCount: postList.length,
                      itemBuilder: (_, index) => ChangeNotifierProvider.value(
                        value: postList[index],
                        child: PostThumbnail(
                          viewType: widget.reviewer == Reviewer.principle
                              ? PostExpandedViewType.principle
                              : PostExpandedViewType.teacher,
                        ),
                      ),
                    ),
                  ),
                ));
    }
    return LoadingScreen();
  }
}
