part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSubmit extends LoginEvent {
  final String username;
  final String password;

  LoginSubmit(this.username, this.password);
}

class LogoutSubmit extends LoginEvent {}
