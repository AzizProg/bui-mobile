
import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';

import '../../domain/entities/user.dart';

class CurrentUserUsecase {
  final IAuthRepository authRepository;
  CurrentUserUsecase({required this.authRepository});

  Future<CurrentUserResponse> call() async {
   return  await authRepository.currentUser;
  }
}