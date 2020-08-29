import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/review_post_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';
import 'package:provider/provider.dart';

/*
  When post gets expanded, this allows the Principle or Teacher to review 
  the contents and provide feedback for each part.
*/

class PostReview extends StatelessWidget {
  final Post postData;

  const PostReview({Key key, this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Provider<PostReviewProvider>(
      create: (context) =>
          PostReviewProvider(postData: postData, reviewer: Reviewer.principle),
      child: Consumer<PostReviewProvider>(
        builder: (context, postReviewProvider, _) => Scaffold(
          appBar: AppBar(
            title: Text(postData.getTitle),
            backgroundColor: kPaleBlue,
            elevation: 0.0,
            actions: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.solidTimesCircle,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await postReviewProvider.deny(postData, postData.getOwnerEmail);
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.solidCheckCircle,
                  color: Colors.green,
                ),
                onPressed: () async {
                  // approval from principle, allow teachers to review
                  await postReviewProvider.approve();
                  Navigator.of(context).pop(); // pop the screen
                },
              ),
            ],
          ),
          body: Container(
            height: screenSize.height,
            width: screenSize.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: postReviewProvider
                      .constructPostAndFeedbackBoxes(screenSize),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
