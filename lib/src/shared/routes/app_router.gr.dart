// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:test_mobile/src/features/auth/interface/login/view/login_page.dart'
    as _i4;
import 'package:test_mobile/src/features/auth/interface/sign_up/view/sign_up_page.dart'
    as _i6;
import 'package:test_mobile/src/features/dashboard/interface/view/dashboard_page.dart'
    as _i1;
import 'package:test_mobile/src/features/details_transaction/interface/views/details_transaction_page.dart'
    as _i2;
import 'package:test_mobile/src/features/profil/interface/view/profile_page.dart'
    as _i5;
import 'package:test_mobile/src/shared/widgets/loader.dart' as _i3;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    DashboardPageRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    DetailsTransactionPageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsTransactionPageRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DetailsTransactionPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    LoaderRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.Loader(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ProfilePage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SignUpPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardPageRoute extends _i7.PageRouteInfo<void> {
  const DashboardPageRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DashboardPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardPageRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DetailsTransactionPage]
class DetailsTransactionPageRoute
    extends _i7.PageRouteInfo<DetailsTransactionPageRouteArgs> {
  DetailsTransactionPageRoute({
    _i8.Key? key,
    required int id,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DetailsTransactionPageRoute.name,
          args: DetailsTransactionPageRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsTransactionPageRoute';

  static const _i7.PageInfo<DetailsTransactionPageRouteArgs> page =
      _i7.PageInfo<DetailsTransactionPageRouteArgs>(name);
}

class DetailsTransactionPageRouteArgs {
  const DetailsTransactionPageRouteArgs({
    this.key,
    required this.id,
  });

  final _i8.Key? key;

  final int id;

  @override
  String toString() {
    return 'DetailsTransactionPageRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.Loader]
class LoaderRoute extends _i7.PageRouteInfo<void> {
  const LoaderRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoaderRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<void> {
  const LoginPageRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ProfilePage]
class ProfilePageRoute extends _i7.PageRouteInfo<void> {
  const ProfilePageRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilePageRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SignUpPage]
class SignUpPageRoute extends _i7.PageRouteInfo<void> {
  const SignUpPageRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPageRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
