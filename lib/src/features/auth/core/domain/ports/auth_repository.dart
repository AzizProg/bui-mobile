import 'package:dartz/dartz.dart';
import 'package:test_mobile/src/features/auth/core/domain/entities/user.dart';
import 'package:test_mobile/src/shared/enums/authentification_status.dart';
import 'package:test_mobile/src/shared/errors/failure.dart';

typedef SignUpResponse = Either<Failure, String>;
typedef LoginResponse = Either<Failure, String>;
typedef LogoutResponse = void;
typedef CurrentUserResponse = UserEntity?;
typedef VerifyUserSessionResponse= bool;
abstract class IAuthRepository<T> {
  Future<SignUpResponse> signUp(String username, String password);
  Future<LoginResponse> login(String username, String password);
  Future<LogoutResponse> get logOut;
  Future<CurrentUserResponse> get currentUser;
  Stream<AuthentificationStatus> get status;
  Future<VerifyUserSessionResponse> get verifyUserSession;
}
