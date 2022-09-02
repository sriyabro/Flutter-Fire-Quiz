class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
    this.quizzes = const [],
  });
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Question> questions;

  Quiz({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
    this.questions = const [],
  });
}

class Report {
  String uid;
  int total;
  Map topics;

  Report({
    this.uid = '',
    this.topics = const {},
    this.total = 0,
  });
}

class Question {
  String text;
  List<Option> options;

  Question({
    this.text = '',
    this.options = const [],
  });
}

class Option {
  String value;
  String detail;
  bool correct;

  Option({
    this.value = '',
    this.detail = '',
    this.correct = false,
  });
}
