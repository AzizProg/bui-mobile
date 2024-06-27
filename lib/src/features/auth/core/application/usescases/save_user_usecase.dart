import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';

class SaveUserUseCase {
  SaveUserUseCase({required this.authRepository});
  IAuthRepository authRepository;

  Future<SignUpResponse> call(String username, String password) async {
   return await authRepository.signUp(username, password);
  }
}
