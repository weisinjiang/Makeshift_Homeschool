  /*
    User object that holds their data
  */

class User {
  String _username;
  String _email;
  String _uid;
  String _photoUrl;
  String _bio;
  String _level;
  int _lessonsCreated;
  int _lessonsCompleted;

  User() {
    this._username = null;
    this._email = null;
    this._uid = null;
    this._photoUrl = null;
    this._bio = null;
    this._level = null;
    this._lessonsCompleted = 0;
    this._lessonsCompleted = 0;
  }

  // Setters
  set setUsername(String name) => this._username = name;
  set setEmail(String email) => this._email = email;
  set setUid(String uid) => this._uid = uid;
  set setPhotoUrl(String url) => this._photoUrl = url;
  set setBio(String bio) => this._bio = bio;
  set setLevel(String level) => this._level = level;
  set setLessonsCreated(int numLessons) => this._lessonsCreated = numLessons;
  set setLessonsCompleted(int numComplete) =>
      this._lessonsCompleted = numComplete;

  // Getters
  String get getName => this._username;
  String get getEmail => this._email;
  String get getUid => this._uid;
  String get getPhotoUrl => this._photoUrl;
  String get getBio => this._bio;
  String get getLevel => this._level;
  int get getLessonCreated => this._lessonsCreated;
  int get getLessonCompleted => this._lessonsCompleted;
}
