// import 'package:cloud_firestore/cloud_firestore.dart';

// /// Controls all Collections in the database with type T
// /// CollectionPath is the name of collection. [ie: .collection("users")]
// /// Or, if  the collection is inside  of a document, the path to the document
// ///  [ie. collection("users").document(id).collection("checkouts")]
// ///
// class Collection<T> {
//   final Firestore _database = Firestore.instance;
//   final String collectionPath;
//   CollectionReference collectionRef;

//   /// Constructor. When called, it needs a collection rference and then sets
//   /// the reference to collectionRef
//   Collection({this.collectionPath}) {
//     collectionRef = _database.collection(collectionPath);
//   }

//   /// Get a reference to all the documents in the collectionPath
//   Future<List<T>> getData() async {
//     var snapshot = await collectionRef.getDocuments();

//   }
// }
