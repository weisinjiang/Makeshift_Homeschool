import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class StudyCategoryListTile extends StatelessWidget {
  final String categoryTitle;
  final List<Post> postList; // Post List can be videos or article types
  final List<VideoPost> videoPostList;
  final bool isVideo;

  const StudyCategoryListTile({Key key, this.categoryTitle, this.postList, this.isVideo, this.videoPostList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: StrokeText(
                  fontSize: 20,
                  text: categoryTitle,
                  strokeColor: Colors.black,
                  textColor: Colors.white,
                  strokeWidth: 3.0,
                ),
              ),
            ),
          ),

          if (!isVideo) ... [
          postList == null || postList.length == 0
          ? Container(height: screenSize.height * 0.20,child: Center(child: Text("Nothing, yet..."),),)
          : Container(
            alignment: Alignment.topCenter,
            height: kIsWeb ? screenSize.height * 0.20 : screenSize.height * 0.30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                  separatorBuilder: (context, int index) => const SizedBox(
                        width: 20,
                      ),
                  itemCount: postList.length,
                  itemBuilder: isVideo // Use different list depending on if it is a video 

                  ? (_, index) => ChangeNotifierProvider.value(
                        value: videoPostList[index],
                        child: PostThumbnail(
                          viewType: PostExpandedViewType.global,
                          isVideo: isVideo,
                        ),
                      )  


                  :(_, index) => ChangeNotifierProvider.value(
                        value: postList[index],
                        child: PostThumbnail(
                          viewType: PostExpandedViewType.global,
                          isVideo: isVideo,
                        ),
                      )),
            ),
          )
          ],
          if (isVideo) ... [
          videoPostList == null || videoPostList.length == 0
          ? Container(height: screenSize.height * 0.20,child: Center(child: Text("Nothing, yet..."),),)
          : Container(
            alignment: Alignment.topCenter,
            height: kIsWeb ? screenSize.height * 0.20 : screenSize.height * 0.30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                  separatorBuilder: (context, int index) => const SizedBox(
                        width: 20,
                      ),
                  itemCount: videoPostList.length,
                  itemBuilder: isVideo // Use different list depending on if it is a video 

                  ? (_, index) => ChangeNotifierProvider.value(
                        value: videoPostList[index],
                        child: PostThumbnail(
                          viewType: PostExpandedViewType.global,
                          isVideo: true,
                        ),
                      )  


                  :(_, index) => ChangeNotifierProvider.value(
                        value: postList[index],
                        child: PostThumbnail(
                          viewType: PostExpandedViewType.global,
                          isVideo: false,
                        ),
                      )),
            ),
          )
          ]
          
        ],
      ),
    );
  }
}
