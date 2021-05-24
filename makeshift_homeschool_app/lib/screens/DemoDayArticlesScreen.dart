

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

// When a user clicks on a demo day topic, this takes care of 
// displaying all the articles for that demo day

class DemoDayArticlesScreen extends StatelessWidget {

  final List<Post> articlesList;
  final String topic;

  const DemoDayArticlesScreen({Key key, this.articlesList, this.topic}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(  
        title: Text("$topic"),
      ),
      body: Center(
        child: Container(  
          height: screenSize.height > 900 ? 900 : screenSize.height * 0.80,
          width: screenSize.width > 900 ? 900 : screenSize.width * 0.80,
          child: AspectRatio(  
            aspectRatio: 16/9,
            child: articlesList.length == 0 
            ? Center(child: Text("No Articles"),)
            : ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, int index) => const Divider(),
              itemCount: articlesList.length,
              itemBuilder: (_, index) => ChangeNotifierProvider.value(
                value: articlesList[index],
                child: PostThumbnail(viewType: PostExpandedViewType.global,isVideo: false,),
              ),
            )
          ),

        ),
      ),
    );
  }
  
}