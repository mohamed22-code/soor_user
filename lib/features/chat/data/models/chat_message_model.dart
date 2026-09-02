class ChatMessageModel {
  final int? id;
  final int? roomId;
  final int? senderId;
  final String? senderName;
  final String message;
  final String? time;
  final String? createdAt;
  final bool isMe;

  ChatMessageModel({
    this.id,
    this.roomId,
    this.senderId,
    this.senderName,
    required this.message,
    this.time,
    this.createdAt,
    this.isMe = false,
  });

  factory ChatMessageModel.fromJson(
    Map<String, dynamic> json, {
    int? currentUserId,
  }) {
    final senderId = json['sender_id'] is int
        ? json['sender_id']
        : int.tryParse(json['sender_id']?.toString() ?? '');
    final message =
        json['message']?.toString() ?? json['text']?.toString() ?? '';
    final time =
        json['time']?.toString() ?? json['created_at']?.toString() ?? '';
    String? displayTime;
    if (time.isNotEmpty) {
      try {
        final dt = DateTime.parse(time);
        displayTime =
            '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      } catch (_) {
        displayTime = time.length > 5 ? time.substring(0, 5) : time;
      }
    }
    final isMe = currentUserId != null && senderId != null
        ? senderId == currentUserId
        : (json['is_me'] as bool? ?? false);
    return ChatMessageModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      roomId: json['room_id'] is int
          ? json['room_id']
          : int.tryParse(json['room_id']?.toString() ?? ''),
      senderId: senderId,
      senderName: json['sender_name']?.toString() ?? json['name']?.toString(),
      message: message,
      time: displayTime ?? '09:15',
      createdAt: json['created_at']?.toString(),
      isMe: isMe,
    );
  }
}

class ChatMessagesResponse {
  final bool? status;
  final String? message;
  final List<ChatMessageModel> data;

  ChatMessagesResponse({this.status, this.message, required this.data});

  factory ChatMessagesResponse.fromJson(dynamic json, {int? currentUserId}) {
    if (json is List) {
      return ChatMessagesResponse(
        data: json
            .map(
              (e) => ChatMessageModel.fromJson(
                e as Map<String, dynamic>,
                currentUserId: currentUserId,
              ),
            )
            .toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      final raw = json['data'];
      List<ChatMessageModel> list = [];
      if (raw is List) {
        list = raw
            .map(
              (e) => ChatMessageModel.fromJson(
                e as Map<String, dynamic>,
                currentUserId: currentUserId,
              ),
            )
            .toList();
      } else if (raw is Map<String, dynamic> && raw['data'] is List) {
        list = (raw['data'] as List)
            .map(
              (e) => ChatMessageModel.fromJson(
                e as Map<String, dynamic>,
                currentUserId: currentUserId,
              ),
            )
            .toList();
      }
      return ChatMessagesResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
      );
    }
    return ChatMessagesResponse(data: []);
  }
}
