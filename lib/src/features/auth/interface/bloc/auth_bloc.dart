import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/current_user_usecase.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/log_out_usecase.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/verify_user_session_usecase.dart';
import 'package:test_mobile/src/features/auth/core/domain/entities/user.dart';
import 'package:test_mobile/src/injection_container.dart';
import 'package:test_mobile/src/shared/enums/authentification_status.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required this.logOutUsecase,
      required this.currentUserUsecase,
      required this.verifyUserSessionUsecase})
      : super(AuthState()) {
    on<AuthLogOutEvent>(_logOut);
    on<AuthStatusChangedEvent>(_statusChanged);
    on<AuthVerifyUserSessionEvent>(_verifyUserSession);
    _authStatusStream = logOutUsecase.authRepository.status
        .listen((status) => add(AuthStatusChangedEvent(status: status)));
  }

  Future<void> _logOut(AuthLogOutEvent event, Emitter<AuthState> emit) async {
    await logOutUsecase.call();
  }

  Future<void> _verifyUserSession(
      AuthVerifyUserSessionEvent event, Emitter<AuthState> emit) async {
    bool isTokenExpired = await verifyUserSessionUsecase.call();
    if (isTokenExpired) {
      emit(state.copyWith(status: AuthentificationStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthentificationStatus.unauthenticated));
    }
  }

  Future<void> _statusChanged(
      AuthStatusChangedEvent event, Emitter<AuthState> emit) async {
    if (event.status == AuthentificationStatus.authenticated) {
      final user = await currentUserUsecase.call();
      if (user != null) {
        emit(state.copyWith(
            status: AuthentificationStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthentificationStatus.unauthenticated));
      }
    } else {
      emit(state.copyWith(status: AuthentificationStatus.unauthenticated));
    }
    ;
  }

  late StreamSubscription<AuthentificationStatus> _authStatusStream;
  final LogOutUsecase logOutUsecase;
  final CurrentUserUsecase currentUserUsecase;
  final VerifyUserSessionUsecase verifyUserSessionUsecase;

  @override
  Future<void> close() {
    _authStatusStream.cancel();
    getIt<AuthBloc>().close();
    print("auth bloc status " + getIt<AuthBloc>().isClosed.toString());
    return super.close();
  }
}
