import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/core/themes/dark_theme.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/profile/presentation/widgets/stats.dart';
import 'package:green_city/generated/l10n.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Helper.getUser();
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.feedback, 'title': S.of(context).submit_feedback},
      {'icon': Icons.announcement, 'title': S.of(context).view_announcements},
      {'icon': Icons.location_on, 'title': S.of(context).report_location},
      {'icon': Icons.chat, 'title': S.of(context).assistant},
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
            ProfileStats(user: userData),
            const SizedBox(height: 20),

            // Feature Buttons
            Expanded(
              child: GridView.builder(
                itemCount: features.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder:
                    (_, i) => _featureCard(
                      icon: features[i]['icon'] as IconData,
                      label: features[i]['title']!,
                      onTap: () {
                        // Add routing logic here
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
