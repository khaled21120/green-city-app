import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../Cubits/Notifications Cubit/notifications_cubit.dart';
import 'widgets/notification_tabs.dart';
import 'widgets/notifications_list.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).notifications)),
        body: Column(
          children: [
            const NotificationTabs(),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotificationsError) {
                    return Center(child: Text(state.message));
                  } else if (state is NotificationsLoaded) {
                    return TabBarView(
                      children: [
                        // Private Tab
                        NotificationList(
                          notifications: state.privateNotifications,
                          onTap: () {},
                        ),
                        // Public Tab
                        NotificationList(
                          notifications: state.publicNotifications,
                          onTap: () {},
                        ),
                      ],
                    );
                  }
                  return const Center(child: Text('No data'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
