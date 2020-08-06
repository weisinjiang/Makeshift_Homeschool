import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_database.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/color_const.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/loadingScreen.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/bootcamp_listTile.dart';
import 'package:provider/provider.dart';

class BootCampScreen extends StatefulWidget {
  @override
  _BootCampScreenState createState() => _BootCampScreenState();
}

class _BootCampScreenState extends State<BootCampScreen> {
  Future<List<BootCampActivity>> bootCampActivities;
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
    print("BOOTCAMP: didChange");
    if (_isInThisWidget) {
      setState(() {
        print("BOOTCAMP: Setting loading to true");
        _isLoadingActivities = true;
      });
      print("BOOTCAMP: Getting Future List");
      bootCampActivities =
          Provider.of<BootCampDatabase>(context).getBootCampActivities();
      print("BOOTCAMP: Setting isin to false");
      userData = Provider.of<AuthProvider>(context).getUser;
      _isInThisWidget = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("BootCamp"),
      backgroundColor: colorPaleSpring,
    );
    final screenHeight =
        (MediaQuery.of(context).size.height) - appBar.preferredSize.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (userData != null) {
      // if user is authenticated and data exists
      return Scaffold(
        appBar: appBar,
        body: FutureBuilder(
          future: bootCampActivities,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BootCampActivity> activities = snapshot.data;
              return Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: screenHeight * 0.30,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("asset/gif/camping.gif"),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                            child: StrokeText(
                          fontSize: 50,
                          strokeColor: Colors.black,
                          strokeWidth: 4.0,
                          text: "Pick an Activity",
                          textColor: Colors.white,
                        ))),
                    Container(
                      height: screenHeight * 0.60,
                      width: screenWidth,
                      child: ListView.builder(  
                        padding: const EdgeInsets.all(10.0),
                        itemCount: activities.length,
                        itemBuilder: (context, index) => BootCampListTile(activity: activities[index],),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return LoadingScreen();
            }
          },
        ),
      );
    } else {
      return LoadingScreen();
    }
  }
}
