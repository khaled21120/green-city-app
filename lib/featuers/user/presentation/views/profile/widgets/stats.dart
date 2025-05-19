import 'package:flutter/material.dart';
import 'package:green_city/core/themes/light_theme.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../auth/data/models/user_model.dart';

class ProfileStats extends StatelessWidget {
  final UserModel user;
  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statsItem(
            context: context,
            title: S.of(context).completed_polls,
            count: user.numOfCompletedPollsCount ?? 0,
            icon: Icons.poll_rounded,
          ),
          _statsItem(
            context: context,
            title: S.of(context).completed_activities,
            count: user.numOfCompletedActivitiesCount ?? 0,
            icon: Icons.eco_rounded,
          ),
          _statsItem(
            context: context,
            title: S.of(context).accepted_reports,
            count: user.numOfAcceptedAnnouncementsCount ?? 0,
            icon: Icons.assignment_turned_in_rounded,
          ),
        ],
      ),
    );
  }
}

Widget _statsItem({
  required BuildContext context,
  required String title,
  required int count,
  required IconData icon,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColors.primary.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: MyColors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: MyColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    ),
  );
}
