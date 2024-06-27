part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUsernameChangedEvent extends LoginEvent {
  const LoginUsernameChangedEvent({required this.username});
  final String username;

  @override
  List<Object?> get props => [username];
}

class LoginPasswordChangedEvent extends LoginEvent {
  const LoginPasswordChangedEvent({required this.password});
  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginShowPasswordEvent extends LoginEvent {
  const LoginShowPasswordEvent();

  @override
  List<Object?> get props => [];
}

class LoginHidePasswordEvent extends LoginEvent {
  const LoginHidePasswordEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmittedEvent extends LoginEvent {
  const LoginSubmittedEvent();

  @override
  List<Object?> get props => [];
}
