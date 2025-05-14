import 'package:flutter/material.dart';

import '../../../../../../../core/themes/light_theme.dart';

class NotificationList extends StatelessWidget {
  final List<dynamic> notifications;
  final VoidCallback onTap;
  const NotificationList({
    super.key,
    required this.notifications,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return notifications.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Card(
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.error,
                  ),
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: MyColors.white),
                ),
                onDismissed: (direction) => onTap,
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications_active,
                    color: MyColors.icons,
                  ),
                  title: Text(
                    notifications[index].notificationContent!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    notifications[index].notificationDate!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MyColors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            );
          },
        )
        : const Center(child: Text("No Notifications"));
  }
}
