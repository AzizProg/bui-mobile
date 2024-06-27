import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';

class LogOutUsecase {
  final IAuthRepository authRepository;
  LogOutUsecase({required this.authRepository});

  Future<LogoutResponse> call() async {
    await authRepository.logOut;
  }
}