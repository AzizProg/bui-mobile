import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:test_mobile/src/app/bloc/app_bloc.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/current_user_usecase.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/get_user_usecase.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/log_out_usecase.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/save_user_usecase.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/verify_user_session_usecase.dart';
import 'package:test_mobile/src/features/auth/core/domain/ports/auth_repository.dart';
import 'package:test_mobile/src/features/auth/infrastructure/adapters/auth_repository_impl.dart';
import 'package:test_mobile/src/features/auth/infrastructure/data_source/auth_local_data_source.dart';
import 'package:test_mobile/src/features/auth/infrastructure/data_source/auth_remote_data_source.dart';
import 'package:test_mobile/src/features/auth/interface/bloc/auth_bloc.dart';

import 'package:test_mobile/src/features/dashboard/core/application/usecases/get_transactions_usecase.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/ports/transaction_repository.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/adapters/transaction_repository_impl.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/data_source/transaction_local_data_source.dart';
import 'package:test_mobile/src/features/details_transaction/core/application/usecases/get_Transaction_by_id_usecase.dart';
import 'package:test_mobile/src/features/details_transaction/core/application/usecases/update_transaction_by_id.dart';
import 'package:test_mobile/src/features/details_transaction/core/domain/ports/details_transaction_repository.dart';
import 'package:test_mobile/src/features/details_transaction/infrastructure/data_source/details_transaction_remote_data_source.dart';
import 'package:test_mobile/src/shared/dio_interceptors/auth_dio_interceptor.dart';
import 'package:test_mobile/src/shared/dio_interceptors/logger_dio_interceptors.dart';
import 'package:test_mobile/src/shared/network/network_checker.dart';
import 'package:test_mobile/src/shared/routes/app_router.dart';

import 'features/dashboard/infrastructure/data_source/transaction_remote_data_source.dart';
import 'features/details_transaction/infrastructure/adapters/details_transaction_repository_impl.dart';

final getIt = GetIt.instance;
void injectionContainer() {
//Network checker
//AppBloc
  getIt.registerLazySingleton<NetworkChecker>(
    () => NetWorkImpl(connectionChecker: InternetConnectionChecker()),
  );
//AppBloc
  getIt.registerLazySingleton<AppBloc>(
    () => AppBloc(),
  );

//logger
  getIt.registerLazySingleton<Logger>(
    () => Logger(),
  );
  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 10),
      ));
      dio.interceptors.addAll([AuthDioInterceptors(), LoggerDioInterceptor()]);

      return dio;
    },
  );

//router
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );

//------------------------Auth------------------------------------------------
//Auth bloc
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
        logOutUsecase: getIt<LogOutUsecase>(),
        currentUserUsecase: getIt<CurrentUserUsecase>(),
        verifyUserSessionUsecase: getIt<VerifyUserSessionUsecase>())
      ..add(AuthVerifyUserSessionEvent()),
  );

//Auth  data sources
  getIt.registerFactory<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerFactory<IAuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

//Auth Repository
  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: AuthRemoteDataSourceImpl(dio: getIt<Dio>()),
        localDataSource: AuthLocalDataSourceImpl(),
        networkChecker: getIt<NetworkChecker>(),
      ));

//auth usescases
  getIt.registerFactory<SaveUserUseCase>(
      () => SaveUserUseCase(authRepository: getIt()));
  getIt.registerFactory<GetUserUseCase>(
      () => GetUserUseCase(authRepository: getIt()));
  getIt.registerFactory<CurrentUserUsecase>(
      () => CurrentUserUsecase(authRepository: getIt()));
  getIt.registerFactory<LogOutUsecase>(
      () => LogOutUsecase(authRepository: getIt()));
  getIt.registerFactory<VerifyUserSessionUsecase>(
      () => VerifyUserSessionUsecase(authRepository: getIt()));

//------------------------Transactions----------------------------------------
//transactions data sources
  getIt.registerFactory<ITransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerFactory<ITransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(),
  );

//transactions Repository
  getIt.registerFactory<ITransactionRepository>(() => TransactionRepositoryImpl(
        remoteDataSource: getIt<ITransactionRemoteDataSource>(),
        localDataSource: getIt<ITransactionLocalDataSource>(),
        networkChecker: getIt<NetworkChecker>(),
      ));

// transactions usescases
  getIt.registerFactory<GetTransactionsUsecase>(() => GetTransactionsUsecase(
      transactionRepository: getIt<ITransactionRepository>()));

//------------------------Details Transactions----------------------------------------
//details transaction data sources
  getIt.registerFactory<IDetailsTransactionRemoteDataSource>(
    () => DetailsTransactionRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

//details transactions Repository
  getIt.registerFactory<IDetailsTransactionRepository>(
      () => DetailsTransactionRepositoryImpl(
            remoteDataSource: getIt<IDetailsTransactionRemoteDataSource>(),
            networkChecker: getIt<NetworkChecker>(),
          ));

// details transactions usescases
  getIt.registerFactory<GetTransactionByIdUsecase>(() =>
      GetTransactionByIdUsecase(
          detailsTransactionRepository:
              getIt<IDetailsTransactionRepository>()));
  getIt.registerFactory<UpdateTransactionById>(() => UpdateTransactionById(
      detailsTransactionRepository: getIt<IDetailsTransactionRepository>()));

//------------------------Profile---------------------------------------
}
