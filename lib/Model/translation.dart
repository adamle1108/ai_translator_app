class TranslationModel {
  int? id;
  String text;
  String answer;

  TranslationModel({
    this.id,
    required this.text,
    required this.answer,
  });

  // Convert a Art object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'answer': answer,
    };
  }

  // Extract a Art object from a Map object
  factory TranslationModel.fromMap(Map<String, dynamic> map) {
    return TranslationModel(
      id: map['id'],
      text: map['text'],
      answer: map['answer'],
    );
  }
}