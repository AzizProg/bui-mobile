import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:test_mobile/src/injection_container.dart';
import 'package:test_mobile/src/shared/observers/app_bloc_observer.dart';
import 'package:test_mobile/src/shared/storage/hive_storage.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await runZonedGuarded(
    () async {
       WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
      );

      await HiveStorage.init();
      injectionContainer();
      Bloc.observer = AppBlocObserver();
      return runApp(await builder());
    },
    (error, stackTrace) {
      log("====================Error on app starting=============="
          "${error}"
          "${stackTrace}"
          "======================================================");
    },
  );
}
