class LoginResponseModel {
  LoginResponseModel({this.status, this.message, this.data});

  LoginResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({this.user, this.token, this.tokenType});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    tokenType = json['token_type'];
  }

  User? user;
  String? token;
  String? tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    map['token_type'] = tokenType;
    return map;
  }
}

class User {
  User({
    this.userId,
    this.userName,
    this.userNickname,
    this.userEmail,
    this.userPhone,
    this.userGender,
    this.userLang,
    this.userCity,
    this.userUniform,
    this.uniformImageUrl,
    this.userStatus,
    this.userActive,
    this.userImg,
    this.userType,
    this.userRoleId,
    this.phoneVerified,
    this.phoneVerifiedAt,
    this.acceptBookings,
  });

  User.fromJson(dynamic json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userNickname = json['user_nickname'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userGender = json['user_gender'];

    if (json['user_lang'] is List) {
      userLang = (json['user_lang'] as List).map((e) => e.toString()).toList();
    }
    userCity = json['user_city'];
    if (json['user_uniform'] is List) {
      userUniform = (json['user_uniform'] as List)
          .map((e) => e.toString())
          .toList();
    }
    uniformImageUrl = json['uniform_image_url'];
    userStatus = json['user_status'];
    userActive = json['user_active'];
    userImg = json['user_img'];
    userType = json['user_type'];
    userRoleId = json['user_role_id'];
    phoneVerified = json['phone_verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    acceptBookings = json['accept_bookings'];
  }

  int? userId;
  String? userName;
  dynamic userNickname;
  String? userEmail;
  String? userPhone;
  dynamic userGender;
  List<dynamic>? userLang;
  dynamic userCity;
  List<dynamic>? userUniform;
  dynamic uniformImageUrl;
  String? userStatus;
  bool? userActive;
  String? userImg;
  String? userType;
  int? userRoleId;
  bool? phoneVerified;
  dynamic phoneVerifiedAt;
  bool? acceptBookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['user_nickname'] = userNickname;
    map['user_email'] = userEmail;
    map['user_phone'] = userPhone;
    map['user_gender'] = userGender;
    if (userLang != null) {
      map['user_lang'] = userLang;
    }
    map['user_city'] = userCity;
    if (userUniform != null) {
      map['user_uniform'] = userUniform;
    }
    map['uniform_image_url'] = uniformImageUrl;
    map['user_status'] = userStatus;
    map['user_active'] = userActive;
    map['user_img'] = userImg;
    map['user_type'] = userType;
    map['user_role_id'] = userRoleId;
    map['phone_verified'] = phoneVerified;
    map['phone_verified_at'] = phoneVerifiedAt;
    map['accept_bookings'] = acceptBookings;
    return map;
  }
}
