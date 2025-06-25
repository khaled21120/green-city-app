import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/widgets/error_widget.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/user/presentation/cubits/activities/activities_cubit.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/activities/widgets/my_challanges_item.dart';
import 'package:green_city/generated/l10n.dart';

class MyActivitiesView extends StatelessWidget {
  const MyActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).my_Activities)),
      body: BlocConsumer<ActivitiesCubit, ActivitiesState>(
        listener: (context, state) {
          if (state is ActivityUnSubscribe) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is ActivitiesError) {
            Helper.showSnackBar(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is ActivitiesLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ActivitiesError) {
            return ErrorsWidget(
              message: state.message,
              onPressed:
                  () async => context.read<ActivitiesCubit>().getMyActivities(),
            );
          } else if (state is MyActivitiesLoaded) {
            if (state.myActivities.isEmpty) {
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
                  () async => context.read<ActivitiesCubit>().getMyActivities(),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.myActivities.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder:
                    (context, index) => MyChallangesItem(
                      activitiesModel: state.myActivities[index],
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
