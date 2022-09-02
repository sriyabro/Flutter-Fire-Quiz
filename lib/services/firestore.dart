import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documents from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  /// Retrive a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    var quiz = Quiz.fromJson(snapshot.data() ?? {});
    return quiz;
  }
}
