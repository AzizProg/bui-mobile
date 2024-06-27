import 'package:flutter/cupertino.dart';


//I use it  to avoid multiple MediaQuery declaration in my code
extension SizeExtension on BuildContext {
  double get screenWidth {
    return MediaQuery.sizeOf(this).width;
  }
  double get screenHeight {
    return MediaQuery.sizeOf(this).height;
  }

  double get getHalfWidth => screenWidth/2;

  double get getThirdOfWidth => screenWidth/3;

  double get getHalfHeight => screenHeight/2;

  double get getThirdOfHeight => screenHeight/3;

  double setHeight(double size) {
    return (screenHeight * size) / screenHeight;
  }
  double setWidth(double size) {
    return (screenWidth * size) / screenWidth;
  }
}