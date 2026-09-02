class ChatRoomModel {
  final int id;
  final int? bookingId;
  final int? userId;
  final int? guardId;
  final String? guardName;
  final String? guardImage;
  final String? lastMessage;
  final String? lastMessageTime;
  final int? unreadCount;
  final String? bookingStatus;

  ChatRoomModel({
    required this.id,
    this.bookingId,
    this.userId,
    this.guardId,
    this.guardName,
    this.guardImage,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount,
    this.bookingStatus,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      bookingId: json['booking_id'] is int
          ? json['booking_id']
          : int.tryParse(json['booking_id']?.toString() ?? ''),
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id']?.toString() ?? ''),
      guardId: json['guard_id'] is int
          ? json['guard_id']
          : int.tryParse(json['guard_id']?.toString() ?? ''),
      guardName:
          json['guard_name']?.toString() ??
          json['name']?.toString() ??
          (json['guard'] is Map
              ? (json['guard'] as Map)['name']?.toString()
              : null) ??
          'Soor',
      guardImage: json['guard_image']?.toString() ?? json['image']?.toString(),
      lastMessage:
          json['last_message']?.toString() ??
          json['last_msg']?.toString() ??
          json['message']?.toString(),
      lastMessageTime:
          json['last_message_time']?.toString() ??
          json['time']?.toString() ??
          json['updated_at']?.toString(),
      unreadCount: json['unread_count'] is int
          ? json['unread_count']
          : int.tryParse(json['unread_count']?.toString() ?? ''),
      bookingStatus: json['booking_status']?.toString(),
    );
  }
}

class ChatRoomsResponse {
  final bool? status;
  final String? message;
  final List<ChatRoomModel> data;

  ChatRoomsResponse({this.status, this.message, required this.data});

  factory ChatRoomsResponse.fromJson(dynamic json) {
    if (json is List) {
      return ChatRoomsResponse(
        data: json
            .map((e) => ChatRoomModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      final raw = json['data'];
      List<ChatRoomModel> list = [];
      if (raw is List) {
        list = raw
            .map((e) => ChatRoomModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (raw is Map<String, dynamic> && raw['data'] is List) {
        list = (raw['data'] as List)
            .map((e) => ChatRoomModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return ChatRoomsResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
      );
    }
    return ChatRoomsResponse(data: []);
  }
}
