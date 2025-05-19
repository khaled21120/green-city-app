import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/error_widget.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/driver/cubits/Driver%20Tasks/driver_tasks_cubit.dart';
import 'package:green_city/featuers/user/home/cubits/User%20Report%20Cubit/user_reports_cubit.dart';
import 'package:green_city/generated/l10n.dart';

import 'widgets/pending_task_item.dart';

class PendingTasksView extends StatelessWidget {
  const PendingTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).pending_tasks)),
      body: BlocBuilder<DriverTasksCubit, DriverTasksState>(
        builder: (context, state) {
          if (state is DriverTasksLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DriverTasksFailure) {
            return ErrorsWidget(
              message: state.errMsg,
              onPressed:
                  () async => context.read<UserReportsCubit>().fetchReports(),
            );
          } else if (state is DriverTasksSuccess) {
            if (state.tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).no_tasks_today,
                      style: MyStyle.title20(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh:
                  () async => context.read<DriverTasksCubit>().getDriverTasks(),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder:
                    (context, index) =>
                        PendingTaskItem(userReportsModel: state.tasks[index]),
              ),
            );
          }
          return Center(
            child: Text(
              S.of(context).no_data_available,
              style: MyStyle.title20(context),
            ),
          );
        },
      ),
    );
  }
}
