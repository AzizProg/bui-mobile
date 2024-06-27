import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/get_user_usecase.dart';
import 'package:test_mobile/src/shared/enums/form_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.getUserUseCase}) : super(const LoginState()) {
    on<LoginUsernameChangedEvent>(_usernameEvent);
    on<LoginPasswordChangedEvent>(_passwordEvent);
    on<LoginSubmittedEvent>(_submitted);
    on<LoginShowPasswordEvent>(_showPassword);
    on<LoginHidePasswordEvent>(_hidePassword);
  }

  final GetUserUseCase getUserUseCase;

  Future<void> _usernameEvent(
      LoginUsernameChangedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(username: event.username));
  }

  Future<void> _passwordEvent(
      LoginPasswordChangedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _showPassword(
      LoginShowPasswordEvent event, Emitter<LoginState> emit) async {
    print(state.isHidden);
    emit(state.copyWith(isHidden: false));
  }

  Future<void> _hidePassword(
      LoginHidePasswordEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isHidden: true));
  }

  Future<void> _submitted(
      LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    print(state.username);
    emit(state.copyWith(status: FormStatus.loading));

    final res = await getUserUseCase.call(state.username, state.password);
    res.fold((failure) {
      emit(
          state.copyWith(status: FormStatus.failure, message: failure.message));
    }, (successMessage) {
      emit(state.copyWith(
        message: successMessage,
        status: FormStatus.success,
      ));

    });

  }
}
