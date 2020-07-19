

class Post {
  int likes; // Database stored as a string, needs to convert
  String _imageUrl;
  String _createdOn;
  String _ownerName;
  String _ownerUid;
  List<String>
      _postContents; // Subtitles and paragraphs in order from Firestore

  Post(this.likes, this._imageUrl, this._createdOn, this._ownerName,
      this._ownerUid, this._postContents);

  //Getters
  int get getLikes => this.likes;
  String get getImageUrl => this._imageUrl;
  String get getCreatedOn => this._createdOn;
  String get getOwnerName => this._ownerName;
  String get getOwnerUid => this._ownerUid;
  List<String> get getPostContents => this._postContents;

  //Setters
  set setLikes(int likes) => this.likes = likes;
  set setImageUrl(String url) => this._imageUrl = url;
  set setCreatedOn(String time) => this._createdOn = time;
  set setOwnerName(String name) => this._ownerName = name;
  set setOwnerUid(String uid) => this._ownerUid = uid;
  set setPostContents(List<String> contents) => this._postContents = contents;
}
