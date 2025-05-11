import 'package:flutter/material.dart';
import 'package:green_city/core/themes/light_theme.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../core/utils/text_style.dart';
import '../../../../auth/data/models/user_model.dart';

class ProfileStats extends StatelessWidget {
  final UserModel user;
  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem(
          title: S.of(context).completed_polls,
          context: context,
          count: user.numOfCompletedPollsCount ?? 0,
        ),
        _statItem(
          context: context,
          title: S.of(context).completed_activities,
          count: user.numOfCompletedActivitiesCount ?? 0,
        ),
        _statItem(
          title: S.of(context).accepted_announcements,
          context: context,
          count: user.numOfAcceptedAnnouncementsCount ?? 0,
        ),
      ],
    );
  }
}

Widget _statItem({
  required String title,
  required int count,
  required BuildContext context,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0), // Padding around the content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyStyle.title14(context).copyWith(
              fontWeight: FontWeight.bold, // Bold title
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '$count',
            style: MyStyle.title16(context).copyWith(
              fontWeight: FontWeight.bold, // Bold for count
              fontSize: 20, // Larger font for better emphasis
              color: MyColors.primary, // Use the primary color for emphasis
            ),
          ),
        ],
      ),
    ),
  );
}
