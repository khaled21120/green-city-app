import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/core/themes/dark_theme.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Helper.getUser();
    final List<Map<String, dynamic>> features = [
      {'icon': FontAwesomeIcons.comment, 'title': S.of(context).submit_feedback},
      {'icon': FontAwesomeIcons.newspaper, 'title': S.of(context).view_announcements},
      {'icon': FontAwesomeIcons.exclamation, 'title': S.of(context).report_location},
      {'icon': FontAwesomeIcons.robot, 'title': S.of(context).assistant},
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${S.of(context).welcome_back} ${userData.name}',
              style: MyStyle.title20(context),
            ),
            const SizedBox(height: 20),

            // Feature Buttons
            Expanded(
              child: GridView.builder(
                itemCount: features.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder:
                    (_, i) => _featureCard(
                      icon: features[i]['icon'] as IconData,
                      label: features[i]['title']!,
                      onTap: () {
                        switch (i) {
                          case 0:
                            GoRouter.of(context).pushNamed('feedbackPage');
                            break;
                          case 1:
                            GoRouter.of(context).pushNamed('myAnnouncements');
                            break;
                          case 2:
                            GoRouter.of(
                              context,
                            ).pushNamed('reportLocationPage');
                            break;
                          case 3:
                            GoRouter.of(context).pushNamed('assistantPage');
                            break;
                        }
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('assistantPage', extra: userData);
        },
        child: const Icon(FontAwesomeIcons.bots),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: MyColors.primary),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
