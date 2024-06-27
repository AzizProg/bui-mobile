import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class ContainerWrapper extends StatelessWidget {
  const ContainerWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.all(context.setWidth(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
