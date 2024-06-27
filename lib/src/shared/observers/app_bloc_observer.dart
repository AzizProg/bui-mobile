import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:test_mobile/src/injection_container.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();
  final Logger log = getIt<Logger>();
  @override
  void onCreate(BlocBase bloc) {
    log.i('''
================================== BLOC CREATE ==========================================
///$bloc
//////////////////////////////////////////////////////////////////////////////////////''');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    log.i('''
================================== BLOC CLOSE ==========================================
///$bloc
//////////////////////////////////////////////////////////////////////////////////////''');
    super.onClose(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log.i('''
================================== BLOC TRANSITION ==========================================
///Event: ${transition.event}
///previous state: ${transition.currentState}
///current state: ${transition.nextState}
//////////////////////////////////////////////////////////////////////////////////////''');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.e('''
================================== BLOC ERROR ==========================================
///Bloc: ${bloc}
///Error: ${error}
///StackStrace: ${stackTrace}
//////////////////////////////////////////////////////////////////////////////////////''');
    super.onError(bloc, error, stackTrace);
  }
}
