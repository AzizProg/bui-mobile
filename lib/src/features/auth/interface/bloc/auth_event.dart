part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthStatusChangedEvent extends AuthEvent {
  AuthStatusChangedEvent({required this.status});
  final AuthentificationStatus status;
}

class AuthLogOutEvent extends AuthEvent {}
class AuthVerifyUserSessionEvent extends AuthEvent {}
