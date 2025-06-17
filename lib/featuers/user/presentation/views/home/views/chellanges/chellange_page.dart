import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/presentation/cubits/activities/activities_cubit.dart';

import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/utils/text_style.dart';
import '../../../../../../../core/widgets/error_widget.dart';
import '../../../../../../../core/widgets/shimmer_grid.dart';
import '../../../../../../../generated/l10n.dart';
import 'widgets/activity_item.dart';

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).activities)),
      body: RefreshIndicator(
        onRefresh: () async => context.read<ActivitiesCubit>().getActivities(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<ActivitiesCubit, ActivitiesState>(
            listener: (context, state) {
              if (state is ActivitiesError) {
                Helper.showSnackBar(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              return _buildContent(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ActivitiesState state) {
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 600;

    // Responsive grid configuration
    final crossAxisCount = isWideScreen ? 3 : 2;
    final childAspectRatio =
        isWideScreen ? 0.8 : screenSize.width / (screenSize.height / 1.2);

    if (state is ActivitiesLoading) {
      return ShimmerGridItem(aspectRatio: childAspectRatio);
    }

    if (state is ActivitiesError) {
      return Center(
        child: ErrorsWidget(
          message: state.message,
          onPressed: () => context.read<ActivitiesCubit>().getActivities(),
        ),
      );
    }

    if (state is ActivitiesLoaded) {
      final availableActivities =
          state.activities
              .where((activity) => activity.actstate == 'Available')
              .toList();

      if (availableActivities.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.poll, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                S.of(context).no_data_available,
                style: MyStyle.title20(context).copyWith(color: Colors.grey),
              ),
              TextButton(
                onPressed:
                    () => context.read<ActivitiesCubit>().getActivities(),
                child: Text(S.of(context).retry),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: availableActivities.length,
        itemBuilder: (context, index) {
          return ActivityItem(
            key: ValueKey(availableActivities[index].id),
            activitiesModel: availableActivities[index],
          );
        },
      );
    }

    // Initial state
    return Center(child: Text(S.of(context).no_data_available));
  }
}
