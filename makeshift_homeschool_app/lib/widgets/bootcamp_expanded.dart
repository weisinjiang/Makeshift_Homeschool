import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

/// After clicking on the ListTitle for bootcamp, the actual lesson will enlarge
class BootCampExpanded extends StatelessWidget {
  final BootCampActivity activity;
  const BootCampExpanded({Key key, this.activity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Text(activity.id),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(

            children: [
              Image.asset("asset/gif/${activity.id}.gif"),
              activity.buildWidget("intro",screenSize),
              SizedBox(height: 20,),
              activity.buildWidget("body", screenSize),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(  
                  icon: Icon(Icons.arrow_right),
                  prefixText: "Reason 1: "
                  
                ),
              ),
               TextField(
                decoration: InputDecoration(  
                  icon: Icon(Icons.arrow_right),
                  prefixText: "Reason 2: "
                  
                ),
              ),
               TextField(
                decoration: InputDecoration(  
                  icon: Icon(Icons.arrow_right),
                  prefixText: "Reason 3: "
                  
                ),
              ),
               TextField(
                decoration: InputDecoration(  
                  icon: Icon(Icons.arrow_right),
                  prefixText: "Reason 4: "
                  
                ),
              ),
               TextField(
                decoration: InputDecoration(  
                  icon: Icon(Icons.arrow_right),
                  prefixText: "Reason 5: "
                  
                ),
              ),
              SizedBox(height: 20,),
              activity.buildWidget("conclusion", screenSize),
            ],
          ),
        ),
      ),
    );
  }
}
