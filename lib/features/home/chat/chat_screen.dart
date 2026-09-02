import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/colors/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/chat_input.dart';
import '../../../core/models/chat_message.dart';
import '../../../core/widgets/custom_chat_bubble.dart';
import '../../chat/data/models/chat_message_model.dart';
import '../../chat/presentation/cubit/chat_cubit.dart';
import '../../chat/presentation/cubit/chat_state.dart';
import 'call_screen.dart';

class ChatScreen extends StatefulWidget {
  final int? roomId;
  final int? bookingId;

  const ChatScreen({super.key, this.roomId, this.bookingId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final roomId = widget.roomId ?? 1;
    final bookingId = widget.bookingId ?? roomId;

    return BlocProvider(
      create: (_) =>
          ChatCubit()..fetchMessages(roomId: roomId, bookingId: bookingId),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(AppAssets.soorLogo),
          actions: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallScreen()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  color: const Color(0xff005875),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.phone_in_talk, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatMessagesLoaded) _scrollToBottom();
            if (state is ChatSendError)
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
          },
          builder: (context, state) {
            if (state is ChatMessagesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryText),
              );
            }
            if (state is ChatMessagesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<ChatCubit>().fetchMessages(
                        roomId: roomId,
                        bookingId: bookingId,
                      ),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }
            List<ChatMessageModel> messages = [];
            if (state is ChatMessagesLoaded) messages = state.messages;
            return Column(
              children: [
                Expanded(
                  child: messages.isEmpty
                      ? const Center(
                          child: Text(
                            'لا توجد رسائل، ابدأ المحادثة الآن',
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.01,
                            vertical: height * 0.02,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final m = messages[index];
                            final bubble = ChatMessage(
                              name:
                                  m.senderName ??
                                  (m.isMe ? 'Soor' : 'احمد محمد'),
                              text: m.message,
                              time: m.time ?? '09:15',
                              isMe: m.isMe,
                            );
                            return CustomChatBubble(message: bubble);
                          },
                        ),
                ),
                ChatInput(
                  controller: messageController,
                  onSend: () {
                    final text = messageController.text.trim();
                    if (text.isEmpty) return;
                    context.read<ChatCubit>().sendMessage(text: text);
                    messageController.clear();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
