class RouteNames {
  RouteNames._();
  //loader
  static String get loader => '/loader';
//Auth routes
  static String get login => '/login';
  static  String get signup => '/sign_up';


  //Dashboard & user authentificated routes
  static String get dashboard => '/dashboard';
  //childs routes : remark not '/'
  static String get profil => '/profil';
  static String get detailsTransaction => '/details_transaction';
}
