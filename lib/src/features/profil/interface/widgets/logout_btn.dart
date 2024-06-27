import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

import '../../../../shared/constants/app_colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onTap, required this.title});
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey),
          ),
          SizedBox(
            width: context.setWidth(10),
          ),
          Icon(
            Icons.logout_outlined,
            color: Colors.grey,
          )
        ],
      ),
    );
    ;
  }
}
