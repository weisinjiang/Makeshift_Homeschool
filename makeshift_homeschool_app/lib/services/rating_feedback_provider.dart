import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/screens/promotion.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';

class Rating_FeedbackProvider with ChangeNotifier {
  double _userRating;
  bool promoted;
  double _allTimeRating;
  int _numUsersRated;
  Post postData;
  // TextEditingController _userFeedbackController;

  Rating_FeedbackProvider({Post postData}) {
    this._userRating = 0.0;
    this.promoted = false;
    this.postData = postData;
    this._allTimeRating = 0.0;
    this._numUsersRated = 0;
    // this._userFeedbackController = TextEditingController();
    // this._userFeedbackController.text = "None";
  }

  // Setters
  set setUserRating(double rate) => this._userRating = rate;
  set setAllTimeRating(double rate) => this._allTimeRating = rate;
  set setNumberOfUsersRated(int numPeople) => this._numUsersRated = numPeople;

  // Getters
  double get getUserRating => this._userRating;
  double get getAllTimeRating => this._allTimeRating;
  int get getNumberOfUsersRated => this._numUsersRated;
  Post get getPostData => this.postData;
  String get getPostId => this.postData.getPostId;
  // String get getFeedback => this._userFeedbackController.text;
  bool get isPromoted => this.isPromoted;

  Widget buildRatingBar(BuildContext context, Size screenSize,
      AuthProvider auth, PostFeedProvider feed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "How did you like this lesson?",
          style: kBoldTextStyle,
        ),
        Text(
          "Tap or drag your finger across the ⭐️'s",
          style: kBoldTextStyle,
        ),
        const SizedBox(
          height: 40,
        ),
        RatingBar.builder(
            allowHalfRating: true,
            direction: Axis.horizontal,
            initialRating: getUserRating,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            unratedColor: Colors.grey[300],
            glow: true,
            glowColor: Colors.green,

            itemBuilder: (context, _) {
              return Icon(
                Icons.star,
                color: Colors.amber,
              );
            },
            onRatingUpdate: (rating) {
              this._userRating = rating;
              notifyListeners();
            }),
        const SizedBox(
          height: 50,
        ),

        const SizedBox(
          height: 80,
        ),

        // Submit button
        Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.80,
          decoration: BoxDecoration(
              color: kGreenPrimary,
              border: Border.all(color: Colors.black, width: 2.0)),
          child: RaisedButton(
            color: kGreenPrimary,
            child: Text(
              "All Done ",
              style: kBoldTextStyle,
            ),
            onPressed: () async {
              // update the ratings for the post
              postData.updatePostRating(
                  userRating: getUserRating, uid: auth.getUserID);
              feed.markAsComplete(getPostId);
              // access user's collection and increment the value
              bool rankedUp =
                  await auth.incrementUserCompletedLessons(getPostId);

              if (rankedUp) {
                Navigator.of(context).pop(); // pop the feedback screen
                // then push the promotion screen
                Navigator.push(
                    context,
                    SlideLeftRoute(
                        screen: PromotionScreen(
                      promotionType: PromotionType.student_to_tutor,
                    )));
              }
              // no promotion, just pop the feedback screen
              else {
                Navigator.of(context).pop(); // pop feed back
                Navigator.of(context).pop(); // pop the lesson
              }
            },
          ),
        )
      ],
    );
  }
}
