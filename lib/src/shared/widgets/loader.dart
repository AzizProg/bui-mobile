import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

import 'package:test_mobile/src/shared/constants/app_images.dart';

@RoutePage()
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.loader,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
