import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluuter_chatgpt/constants/constant.dart';
import 'package:fluuter_chatgpt/models/chat_model.dart';
import 'package:fluuter_chatgpt/providers/chat_provider.dart';
import 'package:fluuter_chatgpt/providers/models_provider.dart';
import 'package:fluuter_chatgpt/services/api_services.dart';
import 'package:fluuter_chatgpt/services/assets_manager.dart';
import 'package:fluuter_chatgpt/services/services.dart';
import 'package:fluuter_chatgpt/widgets/chat_widget.dart';
import 'package:fluuter_chatgpt/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late ScrollController _listScrollController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _listScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 4,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiLogoImage),
          ),
          title: const Text("ChatGPT"),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_vert,
              ),
              onPressed: () async {
                return await Services.showModalSheet(context);
              },
            )
          ]),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatProvider.getChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatProvider.getChatList[index].message,
                    chatIndex: chatProvider.getChatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardCol,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _textEditingController,
                        onSubmitted: (value) async {
                          await sendMessagesFCT(modelsProvider, chatProvider);
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "How can I help you?",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await sendMessagesFCT(modelsProvider, chatProvider);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollToEND() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 2),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendMessagesFCT(
      ModelsProvider modelsProvider, ChatProvider chatProvider) async {
    String msg = _textEditingController.text;
    if (_textEditingController.text.isEmpty) {
      return;
    }
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: TextWidget(
        label: "You cannot send multiple messages at a time",
        color: Colors.red,
      )));
    }
    try {
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(message: _textEditingController.text);
        _textEditingController.clear();
        // to close the keyboard after sending the text
        _focusNode.unfocus();
      });
      await chatProvider.addChatBotMessage(
        message: msg,
        modelId: modelsProvider.getCurrModel,
      );
      setState(() {});
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    } finally {
      setState(() {
        _isTyping = false;
        scrollToEND();
      });
    }
  }
}
