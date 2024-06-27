part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpUsernameChangedEvent extends SignUpEvent {
  const SignUpUsernameChangedEvent({required this.username});
  final String username;

  @override
  List<Object?> get props => [username];
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  const SignUpPasswordChangedEvent({required this.password});
  final String password;

  @override
  List<Object?> get props => [password];
}

class SignUpShowPasswordEvent extends SignUpEvent {
  const SignUpShowPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SignUpHidePasswordEvent extends SignUpEvent {
  const SignUpHidePasswordEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmittedEvent extends SignUpEvent {
  const SignUpSubmittedEvent();

  @override
  List<Object?> get props => [];
}
