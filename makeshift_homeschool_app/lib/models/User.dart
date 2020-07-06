class User {
  String username;
  String email;
  int lesson_completed;
  int lesson_created;
  String level;
  String photoURL;
  String uid;

  User(
      {this.username,
      this.email,
      this.lesson_completed,
      this.lesson_created,
      this.level,
      this.photoURL,
      this.uid});

  String get getUsername => this.username;
  String get getEmail => this.email;
  String get getLessonCompleted => this.lesson_completed.toString();
  String get getLessonCreated => this.lesson_created.toString();
  String get getLevel => this.level;
  String get getPhotoURL => this.photoURL;
  String get getUid => this.uid;
}
