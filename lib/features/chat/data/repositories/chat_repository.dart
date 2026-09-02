import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_room_model.dart';
import '../models/chat_message_model.dart';

class ChatRepository {
  final ChatRemoteDataSource remote;

  ChatRepository({ChatRemoteDataSource? remote})
    : remote = remote ?? ChatRemoteDataSourceImpl();

  Future<(ChatRoomsResponse?, Failure?)> getRooms() async {
    try {
      final res = await remote.getChatRooms();
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(ChatMessagesResponse?, Failure?)> getMessages({
    required int roomId,
    int? currentUserId,
  }) async {
    try {
      final res = await remote.getChatMessages(
        roomId: roomId,
        currentUserId: currentUserId,
      );
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(ChatMessageModel?, Failure?)> sendMessage({
    required int roomId,
    required int bookingId,
    required int senderId,
    required String message,
  }) async {
    try {
      final res = await remote.sendMessage(
        roomId: roomId,
        bookingId: bookingId,
        senderId: senderId,
        message: message,
      );
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(ChatRoomModel?, Failure?)> createRoom({
    required int bookingId,
    required int userId,
    required int guardId,
  }) async {
    try {
      final res = await remote.createRoom(
        bookingId: bookingId,
        userId: userId,
        guardId: guardId,
      );
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
}
