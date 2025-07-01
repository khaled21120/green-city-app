import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/widgets/error_widget.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/driver/presentation/cubits/cubit/paid_tasks_cubit.dart';
import 'package:green_city/generated/l10n.dart';

import 'widgets/pending_paid_task_item.dart';

class PendingPaidTasksView extends StatelessWidget {
  const PendingPaidTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Helper.getUser();
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).pending_tasks)),
      body: BlocBuilder<PaidTasksCubit, PaidTasksState>(
        builder: (context, state) {
          if (state is PaidTasksLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is PaidTasksFailure) {
            return ErrorsWidget(
              message: state.errMsg,
              onPressed:
                  () async => context.read<PaidTasksCubit>().getAcceptedPaidTasks(),
            );
          } else if (state is PaidTasksSuccess) {
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
                  () async =>
                      context.read<PaidTasksCubit>().getAcceptedPaidTasks(),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder:
                    (context, index) => PendingPaidTaskItem(
                      userReportsModel: state.tasks[index],
                      userModel: userData,
                      id: state.tasks[index].id!,
                    ),
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
