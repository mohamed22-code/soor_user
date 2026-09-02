import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/data/repositories/profile_repository.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/repositories/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  final ProfileRepository profileRepository;

  ChatCubit({ChatRepository? repository, ProfileRepository? profileRepo})
    : repository = repository ?? ChatRepository(),
      profileRepository = profileRepo ?? ProfileRepository(),
      super(const ChatInitial());

  int? _currentUserId;
  Timer? _pollingTimer;
  int? _currentRoomId;
  int? _currentBookingId;

  Future<void> _ensureUserId() async {
    if (_currentUserId != null) return;
    final (res, _) = await profileRepository.getProfile();
    _currentUserId = res?.user?.userId ?? 1;
  }

  Future<void> fetchRooms() async {
    emit(const ChatRoomsLoading());
    final (res, failure) = await repository.getRooms();
    if (failure != null) {
      emit(ChatRoomsError(failure.message));
    } else {
      emit(ChatRoomsLoaded(res?.data ?? []));
    }
  }

  Future<void> fetchMessages({required int roomId, int? bookingId}) async {
    _currentRoomId = roomId;
    _currentBookingId = bookingId;
    await _ensureUserId();
    emit(const ChatMessagesLoading());
    final (res, failure) = await repository.getMessages(
      roomId: roomId,
      currentUserId: _currentUserId,
    );
    if (failure != null) {
      final msg = failure.message;
      final isNotFound =
          msg.contains('404') ||
          msg.contains('Not Found') ||
          msg.contains('غير موجود') ||
          msg.contains('No query results') ||
          msg.contains('ChatRoom');
      if (isNotFound) {
        emit(const ChatMessagesLoaded([]));
        _startPolling(roomId);
      } else {
        emit(ChatMessagesError(failure.message));
      }
    } else {
      emit(ChatMessagesLoaded(res?.data ?? []));
      _startPolling(roomId);
    }
  }

  void _startPolling(int roomId) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await _ensureUserId();
      final (res, failure) = await repository.getMessages(
        roomId: roomId,
        currentUserId: _currentUserId,
      );
      if (failure == null && res != null) {
        emit(ChatMessagesLoaded(res.data));
      }
    });
  }

  Future<void> sendMessage({required String text}) async {
    if (_currentRoomId == null || text.trim().isEmpty) return;
    await _ensureUserId();
    final currentState = state;
    List<ChatMessageModel> currentMessages = [];
    if (currentState is ChatMessagesLoaded)
      currentMessages = List.from(currentState.messages);
    final temp = ChatMessageModel(
      message: text.trim(),
      isMe: true,
      time:
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
    );
    emit(ChatMessagesLoaded([...currentMessages, temp]));
    final (res, failure) = await repository.sendMessage(
      roomId: _currentRoomId!,
      bookingId: _currentBookingId ?? _currentRoomId!,
      senderId: _currentUserId!,
      message: text.trim(),
    );
    if (failure != null) {
      final msg = failure.message;
      final isNotFound =
          msg.contains('404') ||
          msg.contains('Not Found') ||
          msg.contains('No query results') ||
          msg.contains('ChatRoom');
      if (isNotFound) {
        return;
      }
      emit(ChatSendError(failure.message));
      emit(ChatMessagesLoaded(currentMessages));
    } else {
      final (fresh, _) = await repository.getMessages(
        roomId: _currentRoomId!,
        currentUserId: _currentUserId,
      );
      if (fresh != null) emit(ChatMessagesLoaded(fresh.data));
    }
  }

  Future<void> createAndOpenRoom({
    required int bookingId,
    required int guardId,
  }) async {
    await _ensureUserId();
    final (res, failure) = await repository.createRoom(
      bookingId: bookingId,
      userId: _currentUserId!,
      guardId: guardId,
    );
    if (failure != null) {
      emit(ChatRoomsError(failure.message));
    } else if (res != null) {
      await fetchMessages(roomId: res.id, bookingId: bookingId);
    }
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
