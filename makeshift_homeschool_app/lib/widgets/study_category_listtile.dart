import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

class StudyCategoryListTile extends StatelessWidget {
  final String categoryTitle;
  final List<Post> postList;

  const StudyCategoryListTile({Key key, this.categoryTitle, this.postList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
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
        postList == null 
        ? Container(  height: screenSize.height * 0.20,child: Center(child: Text("Nothing, yet..."),),)
        : Container(
          alignment: Alignment.topCenter,
          height: screenSize.height * 0.25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                separatorBuilder: (context, int index) => const SizedBox(
                      width: 5,
                    ),
                itemCount: postList.length,
                itemBuilder: (_, index) => ChangeNotifierProvider.value(
                      value: postList[index],
                      child: PostThumbnail(
                        inUsersProfilePage: false,
                      ),
                    )),
          ),
        )
      ],
    );
  }
}
