import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Alternativemovieendings.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Discoveryourfamilieslovelanguages.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Gettoknowaneighbor.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/GetwhatIwantfrommyparents.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Makeyourfavoritegameevenbetter.dart';
import 'package:makeshift_homeschool_app/bootcamp_templates/Yourfavoritefictionalcharacter.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import '../bootcamp_templates/WriteAboutYourFavoriteMemory.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/bootcamp_listTile.dart';
import '../shared/slide_transition.dart';
import 'completed_letters.dart';

/// Starting with 8 classrooms, so the 8 classrooms will be hard coded

class ClassroomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /// 8 classroom names.
    final List<String> classroomNames = [
      "Flutter Apps",
      "Startups",
      "Personality",
      "History",
      "Life School",
      "Roleplay",
      "Cooking",
      "Comedy",
      "Composition",
    ];

    ///
    final List<Function> classroomNav = [
      () => Navigator.push(context, SlideLeftRoute(screen: CompletedLetters())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: MakeYourFavoriteGameEvenBetter())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: WriteAboutYourFavoriteMemory())),
      () =>
          Navigator.push(context, SlideLeftRoute(screen: GetToKnowANeighbor())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: Yourfavoritefictionalcharacter())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: DiscoverYourFamiliesLoveLanguages())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: AlternativeMovieEndings())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: GetWhatIWantFromMyParents())),
      () => Navigator.push(
          context, SlideLeftRoute(screen: GetWhatIWantFromMyParents())),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Classrooms"),
          backgroundColor: kPaleBlue,
        ),
        // Depending on if it is web, return different sets of widgets for bootcamp
        body: kIsWeb
            ? buildWeb(screenSize, classroomNames, classroomNav)
            : buildMobile(screenSize, classroomNames, classroomNav));
  }

  Container buildWeb(Size screenSize, List<String> classroomNames,
      List<Function> classroomNav) {
    return Container(
      alignment: Alignment.center,
      height: screenSize.height,
      width: screenSize.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
                alignment: Alignment.center,
                height: screenSize.height * 0.40,
                width: screenSize.width * 0.50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/classroom.png"),
                      fit: BoxFit.cover),
                ),
                child: Center(
                    child: StrokeText(
                  fontSize: 50,
                  strokeColor: Colors.black,
                  strokeWidth: 6.0,
                  text: "Pick a Classroom",
                  textColor: Colors.black,
                ))),
          ),
          Flexible(
            child: Container(
              height: screenSize.height * 0.55,
              width: screenSize.width * 0.50,
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: 9,
                itemBuilder: (context, index) => BootCampListTile(
                  title: classroomNames[index],
                  navigationFunction: classroomNav[index],

                  /// Make list of nagivation function that matches activity list
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildMobile(Size screenSize, List<String> classroomNames,
      List<Function> classroomNav) {
    return Container(
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
                    image: AssetImage("asset/images/classroom.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                  child: StrokeText(
                fontSize: 45,
                strokeColor: Colors.black,
                strokeWidth: 6.0,
                text: "Pick a Classroom!",
                textColor: Colors.black,
              ))),
          Container(
            height: screenSize.height * 0.55,
            width: screenSize.width,
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: 9,
              itemBuilder: (context, index) => BootCampListTile(
                title: classroomNames[index],
                navigationFunction: classroomNav[index],

                /// Make list of nagivation function that matches activity list
              ),
            ),
          ),
        ],
      ),
    );
  }
}
