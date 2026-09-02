import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../models/chat_room_model.dart';
import '../models/chat_message_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatRoomsResponse> getChatRooms({int perPage = 1000000});

  Future<ChatMessagesResponse> getChatMessages({
    required int roomId,
    int perPage = 1000000,
    int? currentUserId,
  });

  Future<ChatMessageModel> sendMessage({
    required int roomId,
    required int bookingId,
    required int senderId,
    required String message,
  });

  Future<ChatRoomModel> createRoom({
    required int bookingId,
    required int userId,
    required int guardId,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<ChatRoomsResponse> getChatRooms({int perPage = 1000000}) async {
    final res = await dio.get(
      '/chat/rooms',
      queryParameters: {'per_page': perPage},
    );
    return ChatRoomsResponse.fromJson(res.data);
  }

  @override
  Future<ChatMessagesResponse> getChatMessages({
    required int roomId,
    int perPage = 1000000,
    int? currentUserId,
  }) async {
    final res = await dio.get(
      '/chat/rooms/$roomId/messages',
      queryParameters: {'per_page': perPage},
    );
    return ChatMessagesResponse.fromJson(
      res.data,
      currentUserId: currentUserId,
    );
  }

  @override
  Future<ChatMessageModel> sendMessage({
    required int roomId,
    required int bookingId,
    required int senderId,
    required String message,
  }) async {
    final res = await dio.post(
      '/chat/rooms/$roomId/messages',
      data: {
        'booking_id': bookingId,
        'sender_id': senderId,
        'message': message,
      },
    );
    final data = res.data is Map<String, dynamic>
        ? (res.data['data'] ?? res.data)
        : res.data;
    if (data is Map<String, dynamic>) {
      return ChatMessageModel.fromJson(data, currentUserId: senderId);
    }
    return ChatMessageModel(message: message, isMe: true, time: '09:15');
  }

  @override
  Future<ChatRoomModel> createRoom({
    required int bookingId,
    required int userId,
    required int guardId,
  }) async {
    final res = await dio.post(
      '/chat/rooms/start',
      data: {'booking_id': bookingId, 'user_id': userId, 'guard_id': guardId},
    );
    final data = res.data is Map<String, dynamic>
        ? (res.data['data'] ?? res.data)
        : res.data;
    if (data is Map<String, dynamic>) return ChatRoomModel.fromJson(data);
    if (data is List && data.isNotEmpty)
      return ChatRoomModel.fromJson(data.first);
    return ChatRoomModel(id: 1, bookingId: bookingId);
  }
}
