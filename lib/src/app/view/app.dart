import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_mobile/src/app/bloc/app_bloc.dart';
import 'package:test_mobile/src/app/view/theme.dart';
import 'package:test_mobile/src/injection_container.dart';
import 'package:test_mobile/src/shared/enums/authentification_status.dart';
import 'package:test_mobile/src/shared/enums/langage_enum.dart';
import 'package:test_mobile/src/shared/observers/app_routes_observer.dart';
import 'package:test_mobile/src/shared/routes/app_router.dart';
import 'package:test_mobile/src/shared/routes/app_router.gr.dart';

import '../../features/auth/interface/bloc/auth_bloc.dart';
import '../../shared/l10n/l10n.dart';

class App extends StatelessWidget {

  App({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AppBloc>(),
        ),
        BlocProvider.value(
          value: getIt<AuthBloc>(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, next) => prev.status != next.status,
        listener: (context, state) {
          if (state.status == AuthentificationStatus.authenticated) {
            _appRouter.replaceAll([DashboardPageRoute()]);
          } else {
            _appRouter.replaceAll([LoginPageRoute()]);
          }
        },
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (prev, next) => prev.language != next.language,
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: _appRouter.config(
                  navigatorObservers: () => [AppRoutesObserver()]),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              locale: state.language.value,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Language.english.value,
                Language.french.value,
              ],
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );

  }

}
