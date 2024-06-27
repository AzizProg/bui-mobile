import 'package:auto_route/auto_route.dart';
import 'package:test_mobile/src/shared/routes/app_router.gr.dart';
import 'package:test_mobile/src/shared/routes/auth_guard.dart';
import 'package:test_mobile/src/shared/routes/routeName.dart';

@AutoRouterConfig(replaceInRouteName: 'page')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: LoaderRoute.page,
            path: RouteNames.loader,
            type: RouteType.custom(
                transitionsBuilder: TransitionsBuilders.fadeIn)),
        AutoRoute(
          page: LoginPageRoute.page,
          path: RouteNames.login,
          initial: true,
        ),
        AutoRoute(
          page: SignUpPageRoute.page,
          path: RouteNames.signup,
        ),
        AutoRoute(
          page: DashboardPageRoute.page,
          path: RouteNames.dashboard,
        ),
        AutoRoute(
          page: ProfilePageRoute.page,
          path: RouteNames.profil,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: DetailsTransactionPageRoute.page,
          path: RouteNames.detailsTransaction,
          guards: [AuthGuard()],
        ),
      ];
}

//for use
// to generate routes in dev mode
//dart run build_runner watch
//or simple build
//dart run build_runner build
