import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/text_style.dart';
import '../../../../../../generated/l10n.dart';
import '../../../Cubits/Language Cubit/language_cubit.dart';
import '../../../Cubits/Language Cubit/language_state.dart';

class ToggleLanguage extends StatelessWidget {
  const ToggleLanguage({super.key});

  @override
  Widget build(BuildContext context) {
        var localization = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(localization.language, style: MyStyle.title20(context)),
        const SizedBox(height: 10),
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return DropdownButton<Locale>(
              value: state.locale, // Current selected language
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
              ],
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  context.read<LanguageCubit>().changeLanguage(newLocale);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
