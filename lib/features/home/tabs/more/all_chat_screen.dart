import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';
import '../../../../features/chat/data/models/chat_room_model.dart';
import '../../../../features/chat/presentation/cubit/chat_cubit.dart';
import '../../../../features/chat/presentation/cubit/chat_state.dart';
import '../../../home/chat/chat_screen.dart';
import 'widget/service_order_item.dart';

class AllChatScreen extends StatelessWidget {
  const AllChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit()..fetchRooms(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('المحادثات', style: AppStyle.medium16white),
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatRoomsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryText),
              );
            }
            if (state is ChatRoomsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: AppStyle.medium16white,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.read<ChatCubit>().fetchRooms(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryText,
                        ),
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is ChatRoomsLoaded) {
              if (state.rooms.isEmpty) {
                return RefreshIndicator(
                  color: AppColors.primaryText,
                  onRefresh: () => context.read<ChatCubit>().fetchRooms(),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 100),
                      Center(
                        child: Text(
                          'لا توجد محادثات حالياً',
                          style: AppStyle.medium16white,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                color: AppColors.primaryText,
                onRefresh: () => context.read<ChatCubit>().fetchRooms(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: state.rooms.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final ChatRoomModel room = state.rooms[index];
                    return ServiceOrderItem(
                      name: room.guardName ?? 'Soor',
                      service: room.lastMessage ?? 'خدمه ممتازه',
                      time:
                          room.lastMessageTime != null &&
                              room.lastMessageTime!.length >= 5
                          ? room.lastMessageTime!.substring(0, 5)
                          : '13:47',
                      count: room.unreadCount,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            roomId: room.id,
                            bookingId: room.bookingId ?? room.id,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
