import 'package:flutter/material.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/generated/l10n.dart';
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
    final remainingTasks = totalTasks - completedTasks;
    String getTimeOfDayGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) return S.of(context).good_morning;
      if (hour < 17) return S.of(context).good_afternoon;
      return S.of(context).good_evening;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Section
        Text(
          getTimeOfDayGreeting(),
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
                    progressPercent == 1
                        ? '100%🥳'
                        : '${(progressPercent * 100).toInt()}%',
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
                        S.of(context).task_progress,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        progressPercent == 1
                            ? S.of(context).completed_tasks
                            : '${S.of(context).remaining_tasks}: $remainingTasks',
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

        // check tasks Section
        Text(S.of(context).check_tasks, style: MyStyle.title18(context)),
        const SizedBox(height: 15),
      ],
    );
  }
}
