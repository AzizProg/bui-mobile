import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class PasswordField extends StatelessWidget {
  PasswordField({
    required this.title,
    super.key,
    required this.onChanged,
    this.errorMessage,
   required  this.isHidden , required this.passwordToggle,
  });
  final String title;
  final void Function(String value) onChanged;
  final String? errorMessage;
  final bool isHidden;
  final VoidCallback passwordToggle;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.setWidth(5)),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: isHidden,
        style: Theme.of(context).textTheme.bodyMedium,
        maxLength: 8,
        minLines: 1,
        decoration: InputDecoration(
          counterText: '',
          errorText: errorMessage,
          filled: true,
          fillColor: AppColors.background,
          border: InputBorder.none,
          suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              onPressed: passwordToggle,
              icon: Icon(isHidden ? Icons.visibility : Icons.visibility_off)),
          hintText: title,
        ),
      ),
    );
    ;
  }
}
