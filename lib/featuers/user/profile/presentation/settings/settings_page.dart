import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';
import '../../cubit/profile_cubit.dart';
import 'widgets/lang_toggle.dart';
import 'widgets/theme_toggle_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    void showDeleteAccountDialog(BuildContext context) {
      showDialog(
        context: context,
        builder:
            (dialogContext) => Builder(
              builder:
                  (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    title: Text(S.of(context).delete_account),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(S.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ctx
                              .read<ProfileCubit>()
                              .deleteAccount(); 
                        },
                        child: Text(
                          S.of(context).delete,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Settings Options Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    const ThemeToggleSwitch(),
                    const Divider(height: 1, indent: 8, endIndent: 8),
                    const ToggleLanguage(),
                    const Divider(height: 1, indent: 8, endIndent: 8),
                    Row(
                      children: [
                        Text(
                          strings.delete_account,
                          style: MyStyle.title20(
                            context,
                          ).copyWith(color: Colors.red[400]),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.trash),
                          color: Colors.red[400],
                          onPressed: () => showDeleteAccountDialog(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Spacer(),

            // About Section
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                S.of(context).about_app,
                style: MyStyle.title18(
                  context,
                ).copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 12,
                  children: [
                    _buildAboutItem(
                      context,
                      title: S.of(context).version,
                      value: "ⅴ1.0.0",
                    ),
                    _buildAboutItem(
                      context,
                      title: S.of(context).copyright,
                      value: "© 2023 Green City",
                    ),
                    _buildAboutItem(
                      context,
                      title: S.of(context).developed_by,
                      value: "Green City Team",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: MyStyle.title16(context).copyWith(color: Colors.grey[600]),
        ),
        Text(
          value,
          style: MyStyle.title16(context).copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
