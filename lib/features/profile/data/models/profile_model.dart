import '../../../auth/data/models/LoginResponseModel.dart';

class ProfileResponse {
  final bool? status;
  final String? message;
  final User? user;

  ProfileResponse({this.status, this.message, this.user});

  factory ProfileResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      if (json['data'] != null && json['data'] is Map<String, dynamic>) {
        final data = json['data'] as Map<String, dynamic>;
        if (data['user'] != null) {
          return ProfileResponse(
            status: json['status'] as bool?,
            message: json['message']?.toString(),
            user: User.fromJson(data['user']),
          );
        } else if (data['user_name'] != null || data['user_id'] != null) {
          return ProfileResponse(
            status: json['status'] as bool?,
            message: json['message']?.toString(),
            user: User.fromJson(data),
          );
        }
      }
      if (json['user'] != null) {
        return ProfileResponse(
          status: json['status'] as bool?,
          message: json['message']?.toString(),
          user: User.fromJson(json['user']),
        );
      }
    }
    return ProfileResponse(status: false, message: 'Invalid response');
  }
}
