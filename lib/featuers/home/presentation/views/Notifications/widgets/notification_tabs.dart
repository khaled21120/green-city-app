import 'package:flutter/material.dart';
import 'package:green_city/core/themes/light_theme.dart';

import '../../../../../../generated/l10n.dart';

class NotificationTabs extends StatelessWidget {
  const NotificationTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyColors.primaryDark,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TabBar(
          dividerHeight: 0,
          labelColor: MyColors.white,
          unselectedLabelColor: MyColors.grey,
          labelStyle: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: theme.textTheme.bodyMedium,
          tabs: [
            Tab(icon: const Icon(Icons.lock), text: S.of(context).private),
            Tab(icon: const Icon(Icons.public), text: S.of(context).public),
          ],
        ),
      ),
    );
  }
}
