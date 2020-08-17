import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_lesson.dart';
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

      /// Before this page is build, fetch the user's bootcamp lessons
      Provider.of<BootCampProvider>(context)
          .fetchUserBootCampLessons()
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
    final screenSize = MediaQuery.of(context).size; // screen
    final userData = Provider.of<AuthProvider>(context).getUser;
    List<BootCampLesson> userCompletedLessons =
        Provider.of<BootCampProvider>(context).getUserLessons;

    if (userData != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Your Lessons"),
          ),
          body: _isLoading ? LoadingScreen() :Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [kGreenSecondary, kGreenSecondary_analogous1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: screenSize.height,
            width: screenSize.width,
            child: ListView.separated(
              separatorBuilder: (context, int index) => const Divider(),
              itemCount: userCompletedLessons.length,

              /// Not a change notifier because no value can be changed in Completed Lessons yet
              itemBuilder: (context, index) => Provider.value(
                value: userCompletedLessons[index],
                child: LettersListTile(),
              ),
            ),
          ));
    } else {
      return LoadingScreen();
    }
  }
}
