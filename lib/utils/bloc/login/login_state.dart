part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);
}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);
}

class LogoutSuccess extends LoginState {}


