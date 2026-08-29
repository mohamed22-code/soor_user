import 'package:equatable/equatable.dart';
import '../../data/models/LoginResponseModel.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoginSuccess extends AuthState {
  final LoginResponseModel response;

  const AuthLoginSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthRegisterSuccess extends AuthState {
  final LoginResponseModel response;

  const AuthRegisterSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthForgetPasswordSuccess extends AuthState {
  final String phone;
  final String message;

  const AuthForgetPasswordSuccess({required this.phone, required this.message});

  @override
  List<Object?> get props => [phone, message];
}

class AuthVerifySuccess extends AuthState {
  final String phone;
  final String message;

  const AuthVerifySuccess({required this.phone, required this.message});

  @override
  List<Object?> get props => [phone, message];
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;

  const AuthResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthResendSuccess extends AuthState {
  final String message;

  const AuthResendSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
