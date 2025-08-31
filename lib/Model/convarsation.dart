class ChatModel {
  final bool isUser;
  final String text;

  ChatModel(this.isUser, this.text);

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      json['isUser'] as bool,
      json['text'] as String,
    );
  }
}
