import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Alternativemovieendings.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Differentwaystomove.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Discoveryourfamilieslovelanguages.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Gettoknowaneighbor.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/GetwhatIwantfrommyparents.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Makeyourfavoritegameevenbetter.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Practicewinningfriends.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Writeaboutafamilyvacation.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Yourfavoritefictionalcharacter.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import '../bootcamp_templates/WriteAboutYourFavoriteMemory.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/bootcamp_listTile.dart';
import '../shared/slide_transition.dart';
import 'completed_letters.dart';

/// Only have 10 bootcamps, so the 10 lessons will be hard coded

class BootCampScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /// 10 Boot camp activity names. Final bc it is never changing
    final List<String> bootCampActivityNames = [
      "See your Completed Bootcamps",
      "Make your favorite game even better",
      "Write About Your Favorite Memory",
      "Get to know a neighbor",
      "Your favorite fictional character",
      "Discover your families love languages",
      "Alternative movie endings",
      "Get what I want from my parents",
      "Practice winning friends",
      "Write about a family vacation",
      "Different ways to move",
    ];

    ///
    final List<Function> bootcampNav = [
      () => Navigator.push(context,SlideLeftRoute(screen: CompletedLetters())),
      () => Navigator.push(context,SlideLeftRoute(screen: MakeYourFavoriteGameEvenBetter())),
      () => Navigator.push(context,SlideLeftRoute(screen: WriteAboutYourFavoriteMemory())),
      () => Navigator.push(context,SlideLeftRoute(screen: GetToKnowANeighbor())),
      () => Navigator.push(context,SlideLeftRoute(screen: Yourfavoritefictionalcharacter())),
      () => Navigator.push(context,SlideLeftRoute(screen: DiscoverYourFamiliesLoveLanguages())),
      () => Navigator.push(context,SlideLeftRoute(screen: AlternativeMovieEndings())),
      () => Navigator.push(context,SlideLeftRoute(screen: GetWhatIWantFromMyParents())),
      () => Navigator.push(context,SlideLeftRoute(screen: PracticeWinningFriends())),
      () => Navigator.push(context,SlideLeftRoute(screen: WriteAboutAFamilyVacation())),
      () => Navigator.push(context,SlideLeftRoute(screen: DifferentWaysToMove())),
    ];
    

    return Scaffold(
        appBar: AppBar(
          title: Text("Boot Camp"),
          backgroundColor: kPaleBlue,
        ),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: screenSize.height * 0.30,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/gif/camping.gif"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: StrokeText(
                    fontSize: 50,
                    strokeColor: Colors.black,
                    strokeWidth: 6.0,
                    text: "Pick an Activity",
                    textColor: Colors.white,
                  ))),
              Container(
                height: screenSize.height * 0.55,
                width: screenSize.width,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: 11,
                  itemBuilder: (context, index) => BootCampListTile(
                    title: bootCampActivityNames[index],
                    navigationFunction: bootcampNav[index], /// Make list of nagivation function that matches activity list
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
