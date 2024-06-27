part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthentificationStatus status;
  final UserEntity? userEntity;
  AuthState(
      {this.status = AuthentificationStatus.unauthenticated, this.userEntity});

  AuthState copyWith({AuthentificationStatus? status, UserEntity? user}) {
    return AuthState(
        status: status ?? this.status, userEntity: user ?? this.userEntity);
  }

  @override
  List<Object?> get props => [status, userEntity];
}
