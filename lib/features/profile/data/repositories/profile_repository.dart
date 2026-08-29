import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepository({ProfileRemoteDataSource? remote})
    : remote = remote ?? ProfileRemoteDataSourceImpl();

  Future<(ProfileResponse?, Failure?)> getProfile() async {
    try {
      final res = await remote.getProfile();
      if (res.user == null)
        return (null, ServerFailure(res.message ?? 'فشل جلب البيانات'));
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(ProfileResponse?, Failure?)> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      final res = await remote.updateProfile(
        name: name,
        phone: phone,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (res.user == null && res.status == false) {
        return (null, ServerFailure(res.message ?? 'فشل التحديث'));
      }
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(bool, Failure?)> deleteAccount() async {
    try {
      await remote.deleteAccount();
      return (true, null);
    } on DioException catch (e) {
      return (false, ServerFailure.fromDioError(e));
    } catch (e) {
      return (false, ServerFailure(e.toString()));
    }
  }
}
