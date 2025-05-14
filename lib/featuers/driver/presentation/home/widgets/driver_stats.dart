import 'package:flutter/material.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../core/themes/light_theme.dart';
import '../../../../../core/utils/text_style.dart';

class DriverStats extends StatelessWidget {
  const DriverStats({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.progressPercent,
    required this.userData,
  });
  final int completedTasks, totalTasks;
  final double progressPercent;
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    String getTimeOfDayGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) return 'Morning';
      if (hour < 17) return 'Afternoon';
      return 'Evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Section
        Text(
          'Good ${getTimeOfDayGreeting()},',
          style: MyStyle.title18(context).copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(userData.name ?? 'Driver', style: MyStyle.title25(context)),
        const SizedBox(height: 30),

        // Progress Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // Circular Progress
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 12,
                  animation: true,
                  animationDuration: 1000,
                  percent: progressPercent,
                  progressColor: MyColors.primary,
                  backgroundColor: MyColors.primary.withValues(alpha: .1),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '${(progressPercent * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Task Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Progress',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                       completedTasks / totalTasks == 1 ? 'You have completed all tasks for this month' : '$completedTasks out of $totalTasks tasks completed this month.',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Quick Stats Section
         Text(
          'Check Tasks',
          style: MyStyle.title18(context),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
