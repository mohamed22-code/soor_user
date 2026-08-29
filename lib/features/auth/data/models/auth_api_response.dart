class AuthApiResponse {
  final bool? status;
  final String? message;
  final dynamic data;

  AuthApiResponse({this.status, this.message, this.data});

  factory AuthApiResponse.fromJson(Map<String, dynamic> json) {
    return AuthApiResponse(
      status: json['status'] as bool?,
      message: json['message']?.toString(),
      data: json['data'],
    );
  }
}
