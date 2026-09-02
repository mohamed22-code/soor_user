import 'package:equatable/equatable.dart';
import '../../data/models/chat_room_model.dart';
import '../../data/models/chat_message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatRoomsLoading extends ChatState {
  const ChatRoomsLoading();
}

class ChatRoomsLoaded extends ChatState {
  final List<ChatRoomModel> rooms;

  const ChatRoomsLoaded(this.rooms);

  @override
  List<Object?> get props => [rooms];
}

class ChatRoomsError extends ChatState {
  final String message;

  const ChatRoomsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatMessagesLoading extends ChatState {
  const ChatMessagesLoading();
}

class ChatMessagesLoaded extends ChatState {
  final List<ChatMessageModel> messages;

  const ChatMessagesLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatMessagesError extends ChatState {
  final String message;

  const ChatMessagesError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatSending extends ChatState {
  const ChatSending();
}

class ChatSent extends ChatState {
  const ChatSent();
}

class ChatSendError extends ChatState {
  final String message;

  const ChatSendError(this.message);

  @override
  List<Object?> get props => [message];
}
