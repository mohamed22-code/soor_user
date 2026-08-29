import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../models/LoginResponseModel.dart';
import '../models/auth_api_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String phone,
    required String password,
    String? onesignalId,
  });

  Future<LoginResponseModel> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? onesignalId,
  });

  Future<AuthApiResponse> resendVerificationCode({required String phone});

  Future<AuthApiResponse> verifyCode({
    required String phone,
    required String code,
  });

  Future<AuthApiResponse> forgetPassword({required String phone});

  Future<AuthApiResponse> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  });

  Future<AuthApiResponse> deleteAccount();

  Future<LoginResponseModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<LoginResponseModel> login({
    required String phone,
    required String password,
    String? onesignalId,
  }) async {
    final res = await dio.post(
      '/auth/login',
      data: {
        'phone': phone,
        'password': password,
        if (onesignalId != null) 'onesignal_id': onesignalId,
      },
    );
    return LoginResponseModel.fromJson(res.data);
  }

  @override
  Future<LoginResponseModel> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? onesignalId,
  }) async {
    final res = await dio.post(
      '/auth/register',
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        if (onesignalId != null) 'onesignal_id': onesignalId,
        'user_type': 'user',
        'terms_accepted': 1,
      },
    );
    return LoginResponseModel.fromJson(res.data);
  }

  @override
  Future<AuthApiResponse> resendVerificationCode({
    required String phone,
  }) async {
    final res = await dio.post(
      '/auth/resend-verification-code',
      data: {'phone': phone},
    );
    return AuthApiResponse.fromJson(res.data);
  }

  @override
  Future<AuthApiResponse> verifyCode({
    required String phone,
    required String code,
  }) async {
    final res = await dio.post(
      '/auth/verify-code',
      data: {'phone': phone, 'verification_code': code},
    );
    return AuthApiResponse.fromJson(res.data);
  }

  @override
  Future<AuthApiResponse> forgetPassword({required String phone}) async {
    final res = await dio.post('/auth/forget-password', data: {'phone': phone});
    return AuthApiResponse.fromJson(res.data);
  }

  @override
  Future<AuthApiResponse> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final res = await dio.post(
      '/auth/reset-password',
      data: {
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    return AuthApiResponse.fromJson(res.data);
  }

  @override
  Future<AuthApiResponse> deleteAccount() async {
    final res = await dio.post('/auth/delete-account', data: {});
    return AuthApiResponse.fromJson(res.data);
  }

  @override
  Future<LoginResponseModel> getProfile() async {
    final res = await dio.get('/auth/profile');
    if (res.data is Map<String, dynamic> &&
        res.data['data'] != null &&
        res.data['data']['user'] != null) {
      return LoginResponseModel.fromJson(res.data);
    }
    return LoginResponseModel.fromJson(res.data);
  }
}
