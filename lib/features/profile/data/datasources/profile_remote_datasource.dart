import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfile();

  Future<ProfileResponse> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    String? confirmPassword,
  });

  Future<void> deleteAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<ProfileResponse> getProfile() async {
    final res = await dio.get('/auth/profile');
    return ProfileResponse.fromJson(res.data);
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    String? confirmPassword,
  }) async {
    final data = {
      'name': name,
      'phone': phone,
      'email': email,
      if (password != null && password.isNotEmpty) 'password': password,
      if (confirmPassword != null && confirmPassword.isNotEmpty)
        'confirm_password': confirmPassword,
    };
    final res = await dio.post('/auth/update-profile', data: data);
    return ProfileResponse.fromJson(res.data);
  }

  @override
  Future<void> deleteAccount() async {
    await dio.post('/auth/delete-account', data: {});
  }
}
