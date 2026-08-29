import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({ProfileRepository? repository})
    : repository = repository ?? ProfileRepository(),
      super(const ProfileInitial());

  Future<void> fetchProfile() async {
    emit(const ProfileLoading());
    final (res, failure) = await repository.getProfile();
    if (failure != null) {
      emit(ProfileError(failure.message));
    } else if (res?.user != null) {
      emit(ProfileLoaded(res!.user!));
    } else {
      emit(const ProfileError('لا توجد بيانات'));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    String? confirmPassword,
  }) async {
    emit(const ProfileUpdating());
    final normalizedPhone = _normalizePhone(phone);
    final (res, failure) = await repository.updateProfile(
      name: name,
      phone: normalizedPhone,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    if (failure != null) {
      emit(ProfileError(failure.message));
    } else if (res?.user != null) {
      emit(
        ProfileUpdated(
          user: res!.user!,
          message: res.message ?? 'تم التحديث بنجاح',
        ),
      );
      emit(ProfileLoaded(res.user!));
    } else {
      emit(ProfileError(res?.message ?? 'فشل التحديث'));
    }
  }

  Future<void> deleteAccount() async {
    emit(const ProfileLoading());
    final (ok, failure) = await repository.deleteAccount();
    if (failure != null) {
      emit(ProfileError(failure.message));
    } else if (ok) {
      await SecureStorageHelper.deleteToken();
      emit(const ProfileDeleted());
    }
  }

  Future<void> logout() async {
    await SecureStorageHelper.deleteToken();
    emit(const ProfileInitial());
  }

  String _normalizePhone(String raw) {
    var p = raw.trim();
    if (p.startsWith('+966')) return p;
    if (p.startsWith('966')) return '+$p';
    if (p.startsWith('0')) return '+966${p.substring(1)}';
    if (RegExp(r'^5\d{8}$').hasMatch(p)) return '+966$p';
    return p;
  }
}
