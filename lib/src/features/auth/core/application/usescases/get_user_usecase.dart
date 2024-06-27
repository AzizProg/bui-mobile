import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';

class GetUserUseCase {
  GetUserUseCase({required this.authRepository});
  IAuthRepository authRepository;

  Future<LoginResponse> call(String username, String password) async {
    return  await authRepository.login(username, password);
  }
}
