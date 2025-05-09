import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../home/presentation/Cubits/Theme Cubit/theme_cubit.dart';

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        bool isDarkMode = state.themeMode == ThemeMode.dark;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).dark_mode, style: MyStyle.title20(context)),
            Switch.adaptive(
              activeColor: Theme.of(context).colorScheme.secondary,
              inactiveThumbColor: Theme.of(context).colorScheme.primary,
              value: isDarkMode,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
