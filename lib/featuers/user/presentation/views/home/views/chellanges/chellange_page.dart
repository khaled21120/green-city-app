import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/presentation/cubits/Activities%20Cubit/activities_cubit.dart';

import '../../../../../../../core/widgets/error_widget.dart';
import '../../../../../../../generated/l10n.dart';
import 'widgets/activity_item.dart';
import '../../widgets/shimmer_grid.dart';

class ActivityiesView extends StatelessWidget {
  const ActivityiesView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).activities)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
          builder: (context, state) {
            if (state is ActivitiesLoading) {
              return ShimmerGridItem(aspectratio: width / (height / 1.5));
            } else if (state is ActivitiesError) {
              return ErrorsWidget(
                message: state.message,
                onPressed:
                    () async => context.read<ActivitiesCubit>().getActivities(),
              );
            } else if (state is ActivitiesLoaded) {
              // Filter available activities only
              final availableActivities =
                  state.activities
                      .where((activity) => activity.actstate == 'Available')
                      .toList();

              return GridView.builder(
                itemCount: availableActivities.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: width / (height / 1.5),
                ),
                itemBuilder: (context, index) {
                  return ActivityItem(
                    activitiesModel: availableActivities[index],
                  );
                },
              );
            }

            return const Center(child: Text('No Data'));
          },
        ),
      ),
    );
  }
}
