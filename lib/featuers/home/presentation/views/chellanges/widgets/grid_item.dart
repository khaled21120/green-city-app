import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/featuers/home/data/models/activities_model.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../../../core/utils/text_style.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.activitiesModel});
  final ActivitiesModel activitiesModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () {
        if (activitiesModel.numOfSubscribers! /
                activitiesModel.numOfRequiredSubscribers! ==
            1) {
          Helper.showSnackBar(
            context: context,
            message: S.of(context).number_of_participants,
          );
        } else {
          GoRouter.of(context).push('/details', extra: activitiesModel);
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Activity Name
              Text(
                activitiesModel.actName!,
                style: MyStyle.title18(context),
                textAlign: TextAlign.center,
              ),

              // Activity Description
              Text(
                activitiesModel.actDescription!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: MyStyle.title14(context),
                textAlign: TextAlign.center,
              ),

              // Activity DateInterval
              Text(
                activitiesModel.actIntervalDate!,
                style: MyStyle.title14(context),
                textAlign: TextAlign.center,
              ),

              // Activity State (Adaptive Color)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color:
                      activitiesModel.actstate == 'متاحة'
                          ? colorScheme.primary.withValues(alpha: .2)
                          : colorScheme.error.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  activitiesModel.actstate!,
                  style: MyStyle.title14(context).copyWith(
                    color:
                        activitiesModel.actstate == 'متاحة'
                            ? colorScheme.primary
                            : colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Progress Bar
              LinearPercentIndicator(
                animation: true,
                animationDuration: 1000,
                lineHeight: 14,
                percent: (activitiesModel.numOfSubscribers! /
                        activitiesModel.numOfRequiredSubscribers!)
                    .clamp(0.0, 1.0), // Prevents exceeding 1.0
                backgroundColor: colorScheme.primary.withValues(alpha: 0.3),
                progressColor: colorScheme.primary,
              ),

              // Number of Participants
              Text(
                activitiesModel.numOfSubscribers! /
                            activitiesModel.numOfRequiredSubscribers! ==
                        1
                    ? S.of(context).completed
                    : '${activitiesModel.numOfSubscribers}/${activitiesModel.numOfRequiredSubscribers} ${S.of(context).participants}',
                style: MyStyle.title14(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
