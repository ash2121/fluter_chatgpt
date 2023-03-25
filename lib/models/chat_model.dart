class ChatModel {
  final String message;
  final int chatIndex;

  ChatModel({
    required this.message,
    required this.chatIndex,
  });
  factory ChatModel.fronJson(Map<String, dynamic> json) => ChatModel(
        message: json["message"],
        chatIndex: json["chatIndex"],
      );
}
