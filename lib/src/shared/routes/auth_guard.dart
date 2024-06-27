import 'package:auto_route/auto_route.dart';
import 'package:test_mobile/src/injection_container.dart';
import 'package:test_mobile/src/shared/routes/routeName.dart';
import 'package:test_mobile/src/shared/storage/hive_storage.dart';

import '../../features/auth/interface/bloc/auth_bloc.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    showLoadingPage(router);
    //this duration is for example to show loader in dev mode . If I want to go in prod, I will change it.
    await Future.delayed(Duration(seconds: 1));
    bool isAuthenticated = await checkAuthentication();
    print(isAuthenticated);

    if (!isAuthenticated) {
      hideLoadingPage(router);
      resolver.next(true);
    } else {
      hideLoadingPage(router);
      getIt<AuthBloc>().add(AuthLogOutEvent());

    }
  }

  Future<bool> checkAuthentication() async {
    return await HiveStorage.isTokenExpired();
    ;
  }
  Future<bool> redirect() async {
    return await HiveStorage.isTokenExpired();
    ;
  }

  void showLoadingPage(StackRouter router) {
    router.pushNamed(RouteNames.loader);
  }

  void hideLoadingPage(StackRouter router) {
    router.back();
  }
}
