part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
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

  SignUpState copyWith(
      {FormStatus? status,
      String? username,
      String? password,
      String? message,
      bool? isHidden }) {
    return SignUpState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        message: message ?? this.message,
        isHidden: isHidden ?? this.isHidden);
  }

  @override
  List<Object?> get props => [status,username,password, message,isHidden];
}
