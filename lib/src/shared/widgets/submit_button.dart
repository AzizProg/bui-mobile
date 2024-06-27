import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/enums/submit_button_enums.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonType = Buttontype.validate,
    this.buttonState = ButtonState.initial,
  });
  final String title;
  final VoidCallback onTap;

  final ButtonState buttonState;
  Buttontype buttonType;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: buttonState == ButtonState.disabled ? null : onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: buttonType == Buttontype.validate
              ? (buttonState == ButtonState.initial
                  ? AppColors.gradientColor
                  : null)
              : null,
          color: buttonType == Buttontype.validate
              ? (buttonState != ButtonState.initial ? Colors.grey : null)
              : Colors.red,
        ),
        padding: EdgeInsets.all(
          context.setWidth(5),
        ),
        child: Center(
          child: buttonState == ButtonState.loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
