import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/LoginResponseModel.dart';
import '../models/auth_api_response.dart';

class AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepository({AuthRemoteDataSource? remote})
    : remote = remote ?? AuthRemoteDataSourceImpl();

  Future<(LoginResponseModel?, Failure?)> login({
    required String phone,
    required String password,
  }) async {
    try {
      final res = await remote.login(phone: phone, password: password);
      if (res.status == true && res.data?.token != null) {
        await SecureStorageHelper.saveToken(
          res.data!.token!,
          tokenType: res.data!.tokenType ?? 'Bearer',
        );
        return (res, null);
      }

      if (res.status == false) {
        return (null, ServerFailure(res.message ?? 'فشل تسجيل الدخول'));
      }
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(LoginResponseModel?, Failure?)> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final res = await remote.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      if (res.status == true && res.data?.token != null) {
        await SecureStorageHelper.saveToken(
          res.data!.token!,
          tokenType: res.data!.tokenType ?? 'Bearer',
        );
      }
      if (res.status == false) {
        return (null, ServerFailure(res.message ?? 'فشل إنشاء الحساب'));
      }
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(AuthApiResponse?, Failure?)> resendCode({
    required String phone,
  }) async {
    try {
      final res = await remote.resendVerificationCode(phone: phone);
      if (res.status == false)
        return (null, ServerFailure(res.message ?? 'فشل الإرسال'));
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    }
  }

  Future<(AuthApiResponse?, Failure?)> verifyCode({
    required String phone,
    required String code,
  }) async {
    try {
      final res = await remote.verifyCode(phone: phone, code: code);
      if (res.status == false)
        return (null, ServerFailure(res.message ?? 'كود غير صحيح'));
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    }
  }

  Future<(AuthApiResponse?, Failure?)> forgetPassword({
    required String phone,
  }) async {
    try {
      final res = await remote.forgetPassword(phone: phone);
      if (res.status == false)
        return (null, ServerFailure(res.message ?? 'رقم غير مسجل'));
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    }
  }

  Future<(AuthApiResponse?, Failure?)> resetPassword({
    required String phone,
    required String password,
    required String confirm,
  }) async {
    try {
      final res = await remote.resetPassword(
        phone: phone,
        password: password,
        passwordConfirmation: confirm,
      );
      if (res.status == false)
        return (null, ServerFailure(res.message ?? 'فشل إعادة التعيين'));
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    }
  }

  Future<void> logout() async {
    await SecureStorageHelper.deleteToken();
  }
}
