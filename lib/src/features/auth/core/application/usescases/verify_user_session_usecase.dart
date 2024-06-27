import 'package:dartz/dartz.dart';
import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';

import '../../../../../shared/errors/failure.dart';
import '../../domain/entities/user.dart';

class VerifyUserSessionUsecase {
  final IAuthRepository authRepository;
  VerifyUserSessionUsecase({required this.authRepository});

  Future<VerifyUserSessionResponse> call() async {
    return  await authRepository.verifyUserSession;
  }
}