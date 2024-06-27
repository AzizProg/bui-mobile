import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:test_mobile/src/injection_container.dart';

class AppRoutesObserver extends AutoRouterObserver {
  Logger log = getIt<Logger>();
  @override
  void didPush(Route route, Route? previousRoute) {
    log.i('''
================================== ROUTE PUSH EVENT :: ==========================================
///////
/// previous route : ${previousRoute?.settings.name}
/// current route : ${route.settings.name}
/// can pop ? : ${route.navigator?.canPop()}
//////////////////////////////////////////////////////////////////////////////////////''');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log.i('''
================================== ROUTE POP EVENT :: ==========================================
///////
/// current route : ${route.settings.name}
/// previous route : ${previousRoute?.settings.name}
/// can pop ? : ${route.navigator?.canPop()}
//////////////////////////////////////////////////////////////////////////////////////''');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log.i('''
================================== ROUTE REMOVE EVENT :: ==========================================
///////
/// remove route : ${previousRoute?.settings.name}
/// current route : ${route.settings.name}
//////////////////////////////////////////////////////////////////////////////////////''');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log.i('''
================================== ROUTE REPLACE EVENT :: ==========================================
///////
/// old route: ${oldRoute?.settings.name}
/// current route : ${newRoute?.settings.name}
//////////////////////////////////////////////////////////////////////////////////////''');
  }

}
