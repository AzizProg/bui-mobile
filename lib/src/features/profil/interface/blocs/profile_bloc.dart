import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/current_user_usecase.dart';
import 'package:test_mobile/src/features/auth/core/domain/entities/user.dart';
import '../../../auth/core/application/usescases/log_out_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.logOutUsecase, required this.currentUserUsecase})
      : super(ProfileInitial()) {
    on<LogOutEvent>(_logOut);
    on<GetCurrentUserEvent>(_getUserData);
  }
  Future<void> _logOut(LogOutEvent event, Emitter<ProfileState> emit) async {
    await logOutUsecase.call();
  }

  Future<void> _getUserData(
      GetCurrentUserEvent event, Emitter<ProfileState> emit) async {
    final user = await currentUserUsecase.call();
    emit(ProfileLoaded(userEntity: user!));
  }

  final LogOutUsecase logOutUsecase;
  final CurrentUserUsecase currentUserUsecase;
}
