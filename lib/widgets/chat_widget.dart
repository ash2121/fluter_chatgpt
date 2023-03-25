import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_chatgpt/constants/constant.dart';
import 'package:fluuter_chatgpt/services/assets_manager.dart';
import 'package:fluuter_chatgpt/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  final String msg;
  final int chatIndex;

  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBgCol : cardCol,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatIndex == 0
                    ? Image.asset(
                        AssetsManager.userImage,
                        height: 30,
                        width: 30,
                      )
                    : Image.asset(
                        AssetsManager.chatLogoImage,
                        height: 30,
                        width: 30,
                      ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: chatIndex == 0
                      ? DefaultTextStyle(
                          style: const TextStyle(color: Colors.white),
                          child: TextWidget(
                            label: msg.trim(),
                          ),
                        )
                      : AnimatedTextKit(
                          isRepeatingAnimation: false,
                          totalRepeatCount: 1,
                          repeatForever: false,
                          displayFullTextOnTap: true,
                          animatedTexts: [
                            TyperAnimatedText(msg,
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                          ],
                        ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
