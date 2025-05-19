import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/error_widget.dart';
import '../../../../../../core/utils/text_style.dart';
import '../../../../../../generated/l10n.dart';
import '../../../cubits/Notifications Cubit/notifications_cubit.dart';
import 'widgets/notification_tabs.dart';
import 'widgets/notifications_list.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).notifications)),
      body: Column(
        children: [
          NotificationTabs(tabController: _tabController),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotificationsError) {
                  return ErrorsWidget(
                    message: state.message,
                    onPressed:
                        () async =>
                            context
                                .read<NotificationsCubit>()
                                .loadAllNotifications(),
                  );
                } else if (state is NotificationsLoaded) {
                  return TabBarView(
                    controller: _tabController,
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
                return Center(
                  child: Text(
                    S.of(context).no_data_available,
                    style: MyStyle.title20(
                      context,
                    ).copyWith(color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
