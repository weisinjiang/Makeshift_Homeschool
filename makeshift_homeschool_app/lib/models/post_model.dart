
class Post {
  int likes; // Database stored as a string, needs to convert
  String _imageUrl;
  String _createdOn;
  String _ownerName;
  String _ownerUid;
  String _title;
  // Subtitles and paragraphs in order from Firestore
  Map<String, dynamic> _postContents;

  Post() {
    this.likes = 0;
    this._title = null;
    this._imageUrl = null;
    this._createdOn = null;
    this._ownerName = null;
    this._ownerUid = null;
    this._postContents = null;
  }

  //Getters
  int get getLikes => this.likes;
  String get getTitle => this._title; // First in array is title
  String get getImageUrl => this._imageUrl;
  String get getCreatedOn => this._createdOn;
  String get getOwnerName => this._ownerName;
  String get getOwnerUid => this._ownerUid;
  Map<String, dynamic> get getPostContents => this._postContents;

  //Setters
  set setLikes(int likes) => this.likes = likes;
  set setTitle(String title) => this._title = title;
  set setImageUrl(String url) => this._imageUrl = url;
  set setCreatedOn(String time) => this._createdOn = time;
  set setOwnerName(String name) => this._ownerName = name;
  set setOwnerUid(String uid) => this._ownerUid = uid;
  set setPostContents(Map<String, dynamic> contents) =>
      this._postContents = contents;
 
}
