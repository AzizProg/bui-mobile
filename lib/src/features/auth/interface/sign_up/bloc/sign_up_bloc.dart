import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/save_user_usecase.dart';
import 'package:test_mobile/src/shared/enums/form_status.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.saveUserUseCase}) : super(const SignUpState()) {
    on<SignUpUsernameChangedEvent>(_usernameEvent);
    on<SignUpPasswordChangedEvent>(_passwordEvent);
    on<SignUpSubmittedEvent>(_submitted);
    on<SignUpShowPasswordEvent>(_showPassword);
    on<SignUpHidePasswordEvent>(_hidePassword);
  }

  final SaveUserUseCase saveUserUseCase;

  Future<void> _usernameEvent(
      SignUpUsernameChangedEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(username: event.username));
  }

  Future<void> _passwordEvent(
      SignUpPasswordChangedEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _showPassword(
      SignUpShowPasswordEvent event, Emitter<SignUpState> emit) async {
    print(state.isHidden);
    emit(state.copyWith(isHidden: false));
  }

  Future<void> _hidePassword(
      SignUpHidePasswordEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isHidden: true));
  }

  Future<void> _submitted(
      SignUpSubmittedEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: FormStatus.loading));

    final res = await saveUserUseCase.call(state.username, state.password);
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
