part of 'login_bloc.dart';

 class LoginState extends Equatable {
  const LoginState({
    this.status = FormStatus.initial,
    this.message = '',
    this.username = '',
    this.password = '',
    this.isHidden=true,
  });
  final FormStatus status;
  final String username;
  final String password;
  final String message;
  final bool isHidden;

  LoginState copyWith(
      {FormStatus? status,
        String? username,
        String? password,
        String? message,
        bool? isHidden }) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        message: message ?? this.message,
        isHidden: isHidden ?? this.isHidden);
  }

  @override
  List<Object?> get props => [status,username,password, message,isHidden];
}


