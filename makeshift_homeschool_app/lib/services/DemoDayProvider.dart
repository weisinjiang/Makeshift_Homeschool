import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/screens/DemoDayArticlesScreen.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';

/// Takes care of loading articles for demo day


class DemoDayProvider with ChangeNotifier {


  // List of demo day topics
  List<String> demoDayTopicsList;

  // Depending on what topic the user selected
  // it will load the articles for said topic in here
  List<Post> articleList;

  List<String> articleIdList;


  final FirebaseFirestore _database = FirebaseFirestore.instance;

  DemoDayProvider() {
    this.articleList = [];
    this.demoDayTopicsList = [];
    fetchDemoDayTopics();
  }

  List<String> get getDemoDayTopicsList => this.demoDayTopicsList;
  bool topicsIsLoading() {
    return this.demoDayTopicsList.length ==  0;
  }

  // Get the list of demo day topics for user to select which one they want to view
  Future<void> fetchDemoDayTopics() async {
    try {
      // get the topics list 
      DocumentSnapshot demoTopics  = await _database.collection("DemoDay").doc("Topics").get();
      List<dynamic> dynamicList = (demoTopics["topics"] as List).toList();
      demoDayTopicsList = List<String>.from(dynamicList);
      notifyListeners();
    } catch (e) {
      print("Error in fetchDemoDayTopic in DemoDayProvider.dart \n Error: $e");
    }
   
  }

  Future<void> fetchTopicArticles(String topic) async {

    try {
      DocumentSnapshot demoArticleId = await _database.collection("DemoDay").doc(topic).get();
      List<dynamic> dynamicList = (demoArticleId["posts"] as List).toList();
      articleIdList = List<String>.from(dynamicList);

      print(articleIdList);
      // Wherein is limited to 10 articles max
      QuerySnapshot articlesSnapShot = await _database.collection("lessons").where("lessonId", whereIn: articleIdList).get();
      
      List<DocumentSnapshot> articleDocs = articlesSnapShot.docs;
      List<Post> serializedPosts = [];

      articleDocs.forEach((doc) {
        Post post = Post();
        post.setLikes = doc["likes"];
        post.setViews = doc["views"];
        post.setRating = doc["rating"].toDouble();
        post.setNumRaters = doc["raters"];
        post.setCreatedOn = doc["createdOn"];
        post.setAge = doc["age"];
        post.setTitle = doc["title"];
        post.setImageUrl = doc["imageUrl"];
        post.setLikes = doc["likes"];
        post.setOwnerName = doc["ownerName"];
        post.setOwnerUid = doc["ownerUid"];
        post.setPostContents = doc["postContents"];
        post.setPostId = doc.id;
        post.setQuiz = doc["quiz"];
        post.setOwnerEmail = doc["ownerEmail"];
        post.setNumApprovals = doc["approvals"];
        serializedPosts.add(post); // add to local list
      });

      articleList = serializedPosts;
      notifyListeners();

    } catch (e) {
      print("Error in DemoDayProvider FetchTopicArticles. \n Error: $e");
    }
  }

  List<Widget> buildTopicButtons(BuildContext context) {

    List<Widget> topicButtons = [];

    for(String topic in demoDayTopicsList) {
      topicButtons.add(
        Container(
          height: 100,
          width: 150,
          child: AspectRatio(
            aspectRatio: 16/9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.black,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                //minimumSize: Size(150, 100)
              ),
              onPressed: () async {
                await fetchTopicArticles(topic);
                Navigator.push(context, SlideLeftRoute(screen: DemoDayArticlesScreen(articlesList: articleList,topic: topic,)));
              }, 
              child: Text("$topic")
            
            ),
          ),
        )

      );
      topicButtons.add(Divider());

    }

    return topicButtons;
  }

}