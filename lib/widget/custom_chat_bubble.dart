import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_assets.dart';
import 'package:soor_user_app/utils/app_colors.dart';
import 'package:soor_user_app/utils/app_style.dart';

import '../model/chat_message.dart';

class CustomChatBubble extends StatelessWidget {
  final ChatMessage message;

  const CustomChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.02),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        constraints: BoxConstraints(maxWidth: width * 0.70),
        decoration: BoxDecoration(
          color: message.isMe
              ? const Color(0xff00394C)
              : const Color(0xff212121),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            message.isMe
                ? Image.asset(AppAssets.soorChatImage)
                : Image.asset(AppAssets.avatarChatImage),
            SizedBox(width: width * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.name, style: AppStyle.medium16white),
                Text(message.text, style: AppStyle.medium16white),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    message.isMe
                        ? Icon(
                            Icons.done_all,
                            color: Color(0xffD9A300),
                            size: 16,
                          )
                        : SizedBox(),
                    SizedBox(width: width * 0.01),
                    Text(message.time, style: AppStyle.medium14darkGrey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
