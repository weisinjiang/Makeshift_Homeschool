

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/DemoDayProvider.dart';
import 'package:makeshift_homeschool_app/shared/loadingScreen.dart';
import 'package:provider/provider.dart';

/*
  This screen will be placed in main.dart's routes so the webapp can access it
  without login.
  It will display a list of demo day topics and when those topics are pressed,
  it will show a list of articles.
*/
class DemoDayScreen extends StatefulWidget {

  @override
  _DemoDayScreenState createState() => _DemoDayScreenState();
}

class _DemoDayScreenState extends State<DemoDayScreen> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ChangeNotifierProvider<DemoDayProvider>(
      create: (context) => DemoDayProvider(),
      child: Consumer<DemoDayProvider> (  
        builder: (context, demoDayProvider, _) => Scaffold(
          appBar: AppBar(  
            leading: Container(),
            title: Text("Demo Day Topics"),
          ),
          body: demoDayProvider.topicsIsLoading()
          ? LoadingScreen()
          : Center(
            child: Container(
              height: screenSize.height > 900 ? 900 : screenSize.height * 0.80,
              width: screenSize.width > 900 ? 900 : screenSize.width * 0.80,
              child: AspectRatio(
                aspectRatio: 16/9,
                child: ListView(  
                  children: demoDayProvider.buildTopicButtons(context),
                ),
              ),
            ),
          )

        ),
      ),

    );

  }
}