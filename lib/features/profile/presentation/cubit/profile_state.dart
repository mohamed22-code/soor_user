import 'package:equatable/equatable.dart';
import '../../../auth/data/models/LoginResponseModel.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileUpdating extends ProfileState {
  const ProfileUpdating();
}

class ProfileUpdated extends ProfileState {
  final User user;
  final String message;

  const ProfileUpdated({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileDeleted extends ProfileState {
  const ProfileDeleted();
}
