import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/home/presentation/Cubits/Activities%20Cubit/activities_cubit.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../data/repo/home_repo.dart';
import 'widgets/activity_item.dart';
import '../../widgets/shimmer_grid.dart';

class ChellangePage extends StatelessWidget {
  const ChellangePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ActivitiesCubit(getIt<HomeRepo>())..getActivities(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
          builder: (context, state) {
            if (state is ActivitiesLoading) {
              return ShimmerGridItem(aspectratio: width / (height / 1.5));
            } else if (state is ActivitiesError) {
              return Center(child: Text(state.message));
            } else if (state is ActivitiesLoaded) {
              // Filter available activities only
              final availableActivities =
                  state.activities
                      .where((activity) => activity.actstate == 'متاحة')
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
