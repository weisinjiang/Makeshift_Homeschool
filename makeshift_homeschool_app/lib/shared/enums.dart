
enum PromotionType{
  student_to_tutor,
  tutor_to_teacher
}


/*
  When viewing an expanded post, different type of users have different
  access and functions to the post.

  1. owner is when the post is expanded from the owners profile page
      This gives the owner the ability to edit the post and delete it
  2. global is when the post is expanded from the "Lessons" button. 
      This is where users read the post and can be access by everyone globally 
  3. principle is when the post is beign reviewed by the principle

*/
enum PostExpandedViewType {
  owner, 
  global,
  principle,
  teacher
}

/*
  Principle reviews the post and will accept/denie it only
  Teachers have feedback to give to allow users to improve
*/
enum Reviewer {
  principle,
  teacher
}

/*
  Indicate what type of quiz should be shown
*/

enum QuizMode {
  correctOnly,
  correctAndIncorrect
}

/*
  Tutors have a mini tutorial slide after answering each question
  This enum describes which slide to show next during the tutorial
*/
enum TutorTutorialSlides {
  intro,
  body,
  conclusion,
  quiz,
  finish


}
