import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: StrokeText(
                fontSize: 20,
                text: categoryTitle,
                strokeColor: Colors.transparent,
                textColor: Colors.black,
                strokeWidth: 3.0,
              ),
            ),
          ),
          postList == null || postList.length == 0
          ? Container(height: screenSize.height * 0.20,child: Center(child: Text("Nothing, yet..."),),)
          : Container(
            //color: kLightBlue,
            alignment: Alignment.topCenter,
            height: screenSize.height * 0.30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                  separatorBuilder: (context, int index) => const SizedBox(
                        width: 20,
                      ),
                  itemCount: postList.length,
                  itemBuilder: (_, index) => ChangeNotifierProvider.value(
                        value: postList[index],
                        child: PostThumbnail(
                          viewType: PostExpandedViewType.global,
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
