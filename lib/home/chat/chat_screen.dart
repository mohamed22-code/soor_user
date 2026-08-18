import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_assets.dart';
import 'package:soor_user_app/widget/custom_chat_bubble.dart';

import '../../model/chat_message.dart';
import '../../widget/chat_input.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<ChatMessage> messages = [
    ChatMessage(
      name: 'احمد محمد',
      text: 'انتظرك فى الموعد إن شاء الله',
      time: '09:15',
      isMe: false,
    ),
    ChatMessage(
      name: 'soor',
      text: 'إن شاء الله اكون موجود فى الموعد',
      time: '09:15',
      isMe: true,
    ),
  ];

  void sendMessage() {
    final text = messageController.text.trim();
    final name = nameController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add(
        ChatMessage(name: name, text: text, time: '09:15', isMe: true),
      );
    });
    messageController.clear();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.soorLogo),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: Color(0xff005875),
            ),
            padding: EdgeInsets.all(6),
            child: Icon(Icons.phone_in_talk),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.01,
                vertical: height * 0.02,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return CustomChatBubble(message: message);
              },
            ),
          ),

          ChatInput(controller: messageController, onSend: sendMessage),
        ],
      ),
    );
  }
}
