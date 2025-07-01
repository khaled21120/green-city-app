import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../data/models/user_notifiy_model.dart';
import '../../../../../cubits/notify/notify_cubit.dart';
import '../../../../../../../../core/themes/light_theme.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    super.key,
    required this.notifications,
    required this.isPublic,
  });

  final List<UserNotifiyModel> notifications; // ✅ strongly typed
  final bool isPublic;

  void _delete(BuildContext context, UserNotifiyModel item) {
    context.read<NotificationsCubit>().deleteNotification(
      id: item.id!,
      isPublic: isPublic,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_off, size: 64, color: MyColors.grey),
            SizedBox(height: 12),
            Text('No notifications'),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = notifications[index];

        return Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.startToEnd,
          background: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Icon(Icons.delete, color: MyColors.white),
          ),
          onDismissed: (_) => _delete(context, item),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Theme.of(context).cardColor,
            leading: const Icon(
              Icons.notifications_active,
              color: MyColors.icons,
            ),
            title: Text(
              item.notificationContent ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              item.notificationDate ?? '',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: MyColors.grey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}
