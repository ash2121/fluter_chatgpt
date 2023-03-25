import 'package:flutter/cupertino.dart';
import 'package:fluuter_chatgpt/models/chat_model.dart';

import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatModel> _chatList = [];
  List<ChatModel> get getChatList {
    return [..._chatList];
  }

  void addUserMessage({required String message}) {
    _chatList.add(ChatModel(
      message: message,
      chatIndex: 0,
    ));
    notifyListeners();
  }

  Future<void> addChatBotMessage(
      {required String message, required String modelId}) async {
    _chatList.addAll(await ApiServices.sendMessages(
      message: message,
      modelId: modelId,
    ));
    notifyListeners();
  }
}
