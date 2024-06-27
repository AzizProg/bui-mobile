import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/constants/app_images.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/routes/routeName.dart';

class DashboardAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: context.getHalfWidth,
      leading: Padding(
        padding: EdgeInsets.only(left: context.setWidth(10)),
        child: Row(
          children: [
            Image.asset(
              AppImages.logo,
              width: context.setWidth(40),
            ),
            SizedBox(
              width: context.setWidth(10),
            ),
            Text(
              "Wallet",
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
      actions: [
        Container(
            margin: EdgeInsets.only(right: context.setWidth(10)),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
                constraints: const BoxConstraints(),
                onPressed: () =>
                    context.router.pushNamed(RouteNames.profil),
                icon: const Icon(Icons.person_outline)))
      ],
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
