import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit({AuthRepository? repository})
    : repository = repository ?? AuthRepository(),
      super(const AuthInitial());

  String _normalizePhone(String raw) {
    var p = raw.trim();
    // already +966...
    if (p.startsWith('+966')) return p;
    if (p.startsWith('966')) return '+$p';

    if (p.startsWith('0')) {
      p = p.substring(1);
      return '+966$p';
    }
    if (RegExp(r'^5\d{8}$').hasMatch(p)) {
      return '+966$p';
    }
    return p;
  }

  Future<void> login({required String phone, required String password}) async {
    emit(const AuthLoading());
    final normalized = _normalizePhone(phone);
    final (res, failure) = await repository.login(
      phone: normalized,
      password: password,
    );
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else if (res != null) {
      emit(AuthLoginSuccess(res));
    } else {
      emit(const AuthFailure('حدث خطأ غير متوقع'));
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(const AuthLoading());
    final normalized = _normalizePhone(phone);
    final (res, failure) = await repository.register(
      name: name,
      phone: normalized,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else if (res != null) {
      emit(AuthRegisterSuccess(res));
    } else {
      emit(const AuthFailure('حدث خطأ غير متوقع'));
    }
  }

  Future<void> forgetPassword({required String phone}) async {
    emit(const AuthLoading());
    final normalized = _normalizePhone(phone);
    final (res, failure) = await repository.forgetPassword(phone: normalized);
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(
        AuthForgetPasswordSuccess(
          phone: normalized,
          message: res?.message ?? 'تم إرسال الكود',
        ),
      );
    }
  }

  Future<void> verifyCode({required String phone, required String code}) async {
    emit(const AuthLoading());
    final normalized = _normalizePhone(phone);
    final (res, failure) = await repository.verifyCode(
      phone: normalized,
      code: code,
    );
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(
        AuthVerifySuccess(
          phone: normalized,
          message: res?.message ?? 'تم التحقق',
        ),
      );
    }
  }

  Future<void> resendCode({required String phone}) async {
    emit(const AuthLoading());
    final normalized = _normalizePhone(phone);
    final (res, failure) = await repository.resendCode(phone: normalized);
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthResendSuccess(res?.message ?? 'تم إعادة الإرسال'));
    }
  }

  Future<void> resetPassword({
    required String phone,
    required String password,
    required String confirm,
  }) async {
    emit(const AuthLoading());
    final normalized = _normalizePhone(phone);
    final (res, failure) = await repository.resetPassword(
      phone: normalized,
      password: password,
      confirm: confirm,
    );
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthResetPasswordSuccess(res?.message ?? 'تم تغيير كلمة المرور'));
    }
  }

  void reset() => emit(const AuthInitial());
}
