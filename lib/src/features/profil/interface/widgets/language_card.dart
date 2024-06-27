import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../injection_container.dart';
import '../../../../shared/enums/langage_enum.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(
      {super.key,
      required this.onTap,
      required this.title,
      required this.value});
  final VoidCallback onTap;
  final String title;
  final Object value;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      enableFeedback: true,

      onTap: onTap,

      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.black, fontSize: 16),
      ),
      leading: Radio(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        value: value,
        groupValue: getIt<AppBloc>().state.language,
        onChanged: (Object? value) {},
      ),
    );
  }
}
