import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/promo/tutor_bootcamp.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';

/*
  This screen shows when a user meets the requirements for a promotion
  1. Student -> Tutor : Complete 5 lessons
  2. Tutor -> Teacher : Create 5 lessons and approved by teachers and principle
*/

class PromotionScreen extends StatelessWidget {
  final PromotionType promotionType;

  const PromotionScreen({Key key, this.promotionType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Congratulations!"),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(promotionType == PromotionType.student_to_tutor)...[
              Text("Congradulations! You have completed 5 lessons!", style: kBoldTextStyle,),
              Text("You are now a Tutor and you can now use the Teach Button!", style: kBoldTextStyle,),
              RaisedButton(  
                child: Text("Continue"),
                color: Colors.greenAccent,
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp1()));},
              )
            ]
          ],
        ),
      ),
    );
  }
}
