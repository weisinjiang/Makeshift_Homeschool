import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/message_form.dart';

class MassagingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(  
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("Join The Conversation!", style: TextStyle(color: Colors.white,)),
      ),
      backgroundColor: Colors.black87,
      body: Column(  
        children: [
          Expanded(
            child: Container(  
            ),
          ),
          MessageForm()
        ],
      ),
    );
  }
}