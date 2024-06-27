import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_mobile/src/features/auth/core/domain/entities/user.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({super.key, required this.user});

  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.background,
          radius: context.setWidth(30),
          child: Icon(
            Icons.person_outline,
            size: context.setWidth(30),
          ),
        ),
        SizedBox(
          width: context.setWidth(10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: _textStyle(context),
                    text: "Username : ",
                    children: [
                  TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      text: user.username)
                ])),
            RichText(
                text: TextSpan(
                    style: _textStyle(context),
                    text: "Created At : ",
                    children: [
                  TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      text:
                          "${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}, ${user.createdAt.hour}:${user.createdAt.minute}")
                ])),
          ],
        )
      ],
    );
  }

  TextStyle? _textStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold);
  }
}
