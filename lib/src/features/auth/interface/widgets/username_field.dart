import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class UsernameField extends StatelessWidget {
  const UsernameField(
      {required this.title,
      super.key,
      required this.onChanged,
      this.errorMessage});
  final String title;
  final String? errorMessage;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.setWidth(5)),
      child: TextFormField(
        maxLength: 8,
        maxLines: 1,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,

        decoration: InputDecoration(
          counterText: '',
          errorText: errorMessage,
            fillColor: AppColors.background,
            filled: true,
            hintText: title,
            border: InputBorder.none),
      ),
    );
  }
}
