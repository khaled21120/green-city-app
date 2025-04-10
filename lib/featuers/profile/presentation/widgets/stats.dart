import 'package:flutter/material.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/utils/text_style.dart';
import '../../../auth/data/models/user_model.dart';

class ProfileStats extends StatelessWidget {
  final UserModel user;
  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem(
          title: S.of(context).polls,
          context: context,
          count: user.numOfCompletedPollsCount ?? 0,
        ),
        _statItem(
          context: context,
          title: S.of(context).activities,
          count: user.numOfCompletedActivitiesCount ?? 0,
        ),
        _statItem(
          title: S.of(context).announcements,
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title, style: MyStyle.title14(context)),
          Text(count.toString(), style: MyStyle.title16(context)),
        ],
      ),
    ),
  );
}
