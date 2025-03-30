import 'package:flutter/material.dart';
import 'package:green_city/featuers/home/presentation/views/settings/widgets/theme_toggle_switch.dart';

import '../../../../../core/utils/text_style.dart';
import '../../../../../generated/l10n.dart';
import 'widgets/lang_toggle.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ThemeToggleSwitch(),
            const ToggleLanguage(),
            const Spacer(),
            const Divider(thickness: 1, color: Colors.grey),
            Text("About", style: MyStyle.title18(context)),
            Text("Version 1.0.0", style: MyStyle.title16(context)),
            Text(
              "Copyright © 2023 Green City Cleaning Department",
              style: MyStyle.title16(context),
            ),
            Text(
              "Powered by Green City Cleaning Department",
              style: MyStyle.title16(context),
            ),
          ],
        ),
      ),
    );
  }
}
