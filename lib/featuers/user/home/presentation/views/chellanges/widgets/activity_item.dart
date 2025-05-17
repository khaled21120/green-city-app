// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/featuers/user/home/data/models/activities_model.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../../../../core/utils/text_style.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({super.key, required this.activitiesModel});
  final ActivitiesModel activitiesModel;

  @override
  Widget build(BuildContext context) {
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
          GoRouter.of(
            context,
          ).pushNamed('activityDetails', extra: activitiesModel);
        }
      },
      child: Stack(
        children: [
          // Background Image
          if(activitiesModel.imgFile != null)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(activitiesModel.imgFile!),
                ),
              ),
            ),
          ),

          // Dark overlay for readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black54,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  activitiesModel.actName!,
                  style: MyStyle.title18(context).copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  activitiesModel.actDescription!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: MyStyle.title14(
                    context,
                  ).copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                Text(
                  activitiesModel.actIntervalDate!,
                  style: MyStyle.title14(
                    context,
                  ).copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    activitiesModel.actstate!,
                    style: MyStyle.title14(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 14,
                  percent: (activitiesModel.numOfSubscribers! /
                          activitiesModel.numOfRequiredSubscribers!)
                      .clamp(0.0, 1.0),
                  backgroundColor: Colors.white24,
                  progressColor: Colors.greenAccent,
                ),
                Text(
                  activitiesModel.numOfSubscribers! /
                              activitiesModel.numOfRequiredSubscribers! ==
                          1
                      ? S.of(context).completed
                      : '${activitiesModel.numOfSubscribers}/${activitiesModel.numOfRequiredSubscribers} ${S.of(context).participants}',
                  style: MyStyle.title14(context).copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
