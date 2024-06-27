import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';
import 'package:test_mobile/src/features/auth/infrastructure/data_source/auth_local_data_source.dart';
import 'package:test_mobile/src/features/auth/infrastructure/data_source/auth_remote_data_source.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/mappers/transaction_mapper.dart';
import 'package:test_mobile/src/shared/constants/response_message.dart';
import 'package:test_mobile/src/shared/enums/authentification_status.dart';
import 'package:test_mobile/src/shared/errors/error_handler.dart';
import 'package:test_mobile/src/shared/errors/failure.dart';
import 'package:test_mobile/src/shared/network/network_checker.dart';

class AuthRepositoryImpl extends IAuthRepository {
  AuthRepositoryImpl({
    required this.networkChecker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final _controller = StreamController<AuthentificationStatus>();
  final IAuthRemoteDataSource remoteDataSource;
  final IAuthLocalDataSource localDataSource;
  final NetworkChecker networkChecker;

  @override
  Future<CurrentUserResponse> get currentUser async {
    return await localDataSource.getUserData;
  }

  @override
  Future<LogoutResponse> get logOut async {
    await localDataSource.deleteSession;
    _controller.add(AuthentificationStatus.unauthenticated);
  }

  @override
  Future<LoginResponse> login(String username, String password) async {
    if (await networkChecker.isConnected) {
      try {
        final res = await remoteDataSource.getUser(username, password);
        final token = jsonDecode(res);

        if (token == null || token['access_token'] == null) {
          return Left(Failure(message: "Invalid token received"));
        }

        final user =
            await localDataSource.saveToken(token['access_token'] as String);

        await localDataSource.saveUserData(user);

        if (user.transactions != null && user.transactions!.isNotEmpty) {
          final transactionMapper = user.transactions!
              .map((transactionEntity) =>
                  TransactionMapper.fromEntity(transactionEntity))
              .toList();
          await localDataSource.saveTransaction(transactionMapper);
        }
        _controller.add(AuthentificationStatus.authenticated);
        return Right(ResponseMessage.SUCCESS);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(Failure(message: ResponseMessage.SERVER_ERROR));
    }
  }

  @override
  Future<SignUpResponse> signUp(String username, String password) async {
    if (await networkChecker.isConnected) {
      try {
        final res = await remoteDataSource.saveUser(username, password);
        final token = jsonDecode(res);
        final user =
            await localDataSource.saveToken(token['access_token'] as String);
        await localDataSource.saveUserData(user);
        _controller.add(AuthentificationStatus.authenticated);
        return const Right('User has been created');
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(Failure(message: ResponseMessage.SERVER_ERROR));
    }
  }

  @override
  Stream<AuthentificationStatus> get status async* {
    yield AuthentificationStatus.unauthenticated;
    yield* _controller.stream;
    print("status controller status:" + _controller.stream.toString());
  }

  @override
  Future<VerifyUserSessionResponse> get verifyUserSession async {
    return await localDataSource.verifyToken;
  }

  void dispose() {
    _controller.close();
  }
}
