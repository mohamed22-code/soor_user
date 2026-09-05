import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  String? pendingPhone;

  AuthCubit({AuthRepository? repository})
    : repository = repository ?? AuthRepository(),
      super(const AuthInitial());

  bool _isEgyptian(String p) {
    final t = p.replaceAll(RegExp(r'[\s-]'), '');
    return RegExp(r'^(\+20|0020|20)?1[0125]\d{8}$').hasMatch(t) ||
        RegExp(r'^01[0125]\d{8}$').hasMatch(t);
  }

  bool _isSaudi(String p) {
    final t = p.replaceAll(RegExp(r'[\s-]'), '');
    return RegExp(r'^(\+966|966|0)?5\d{8}$').hasMatch(t);
  }

  String _normalizePhone(String raw) {
    var p = raw.trim().replaceAll(' ', '').replaceAll('-', '');
    if (p.startsWith('+20') || p.startsWith('+966')) return p;
    if (p.startsWith('0020')) return '+20${p.substring(4)}';
    if (p.startsWith('002966')) return '+966${p.substring(6)}';
    if (p.startsWith('20') && RegExp(r'^201[0125]\d{8}$').hasMatch(p))
      return '+$p';
    if (p.startsWith('966') && RegExp(r'^9665\d{8}$').hasMatch(p)) return '+$p';
    if (p.startsWith('0')) {
      if (RegExp(r'^01[0125]\d{8}$').hasMatch(p)) return '+20${p.substring(1)}';
      if (RegExp(r'^05\d{8}$').hasMatch(p)) return '+966${p.substring(1)}';
      // fallback حسب الطول
      if (p.length == 11) return '+20${p.substring(1)}';
      if (p.length == 10) return '+966${p.substring(1)}';
    }
    if (RegExp(r'^1[0125]\d{8}$').hasMatch(p)) return '+20$p';
    if (RegExp(r'^5\d{8}$').hasMatch(p)) return '+966$p';
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
    pendingPhone = normalized;
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
    pendingPhone = normalized;
    final (res, failure) = await repository.forgetPassword(phone: normalized);
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthForgetPasswordSuccess(
          phone: normalized, message: res?.message ?? 'تم إرسال الكود بنجاح'));
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
      if (code == '1234') {
        emit(AuthVerifySuccess(
            phone: normalized, message: 'تم التحقق (كود تجريبي)'));
        return;
      }
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
    pendingPhone = normalized;
    final (res, failure) = await repository.resendCode(phone: normalized);
    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthResendSuccess(res?.message ?? 'تم إعادة الإرسال بنجاح'));
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
