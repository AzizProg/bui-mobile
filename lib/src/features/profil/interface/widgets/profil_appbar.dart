import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';

class ProfilAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ProfilAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Text(title,style: Theme.of(context).textTheme.titleMedium,),
      centerTitle: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
