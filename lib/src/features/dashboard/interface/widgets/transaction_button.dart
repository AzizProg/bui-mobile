import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class TransactionButton extends StatelessWidget {
  const TransactionButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title});
  final IconData icon;
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(context.setWidth(10)),
            decoration: BoxDecoration(
                color: AppColors.background, shape: BoxShape.circle),
            child: Icon(icon),
          ),
          Text(title,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black
          ),)
        ],
      ),
    );
  }
}
