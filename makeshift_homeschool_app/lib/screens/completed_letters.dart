import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/models/letter.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/letters_listtile.dart';
import 'package:provider/provider.dart';

class CompletedLetters extends StatefulWidget {
  @override
  _CompletedLettersState createState() => _CompletedLettersState();
}

class _CompletedLettersState extends State<CompletedLetters> {
  Future<List<Letter>> userLetters;
  Map<String, String> userData;

  var _isInThisWidget =
      true; // makes sure getting the providers only execute once
  var _isLoadingActivities = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("SAVED LETTERS: didChange");
    if (_isInThisWidget) {
      setState(() {
        print("SAVED LETTERS: Setting loading to true");
        _isLoadingActivities = true;
      });
      print("SAVED LETTERS: Getting Future List");
      userData = Provider.of<AuthProvider>(context).getUser;
      userLetters = Provider.of<BootCampProvider>(context)
          .getSavedLetters(userData["uid"]);
      print("SAVED LETTERS: Setting isin to false");
      _isInThisWidget = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // screen

    if (userData != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Your Letters"),
        ),
        body: FutureBuilder(
            future: userLetters,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Letter> lettersList = snapshot.data;
                return lettersList.length > 0
                    ? Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: lettersList.length,
                            itemBuilder: (context, index) => LettersListTile(
                                  letter: lettersList[index],
                                )),
                      )
                    : Center(
                        child: Container(
                        child: Text("No letters, yet"),
                      ));
              } else {
                return LoadingScreen();
              }
            }),
      );
    } else {
      return LoadingScreen();
    }
  }
}
