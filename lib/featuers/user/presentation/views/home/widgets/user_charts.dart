// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../../core/utils/text_style.dart';

class UserStatsBarChart extends StatelessWidget {
  const UserStatsBarChart({super.key, required this.userData});

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    final statsData = [
      20,
      50,
      60
      // userData.numOfAcceptedAnnouncementsCount ?? 0,
      // userData.numOfCompletedActivitiesCount ?? 0,
      // userData.numOfCompletedPollsCount ?? 0,
    ];

    final maxValue = statsData.reduce((a, b) => a > b ? a : b).toDouble();
    final labels = [
      S.of(context).accepted_reports,
      S.of(context).completed_activities,
      S.of(context).completed_polls,
    ];
    final key = [
      S.of(context).reports,
      S.of(context).activities,
      S.of(context).polls,
    ];
    final gradientColors = [
      [Colors.blueAccent, Colors.lightBlueAccent],
      [Colors.teal, Colors.tealAccent],
      [Colors.orange, Colors.orangeAccent],
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).your_contributions,
              style: MyStyle.title20(context).copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).activity_overview,
              style: MyStyle.title14(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 1.6,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxValue * 1.2,
                  minY: 0,
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value == meta.min || value == meta.max) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            value.toInt().toString(),
                            style: MyStyle.title12(context).copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 44,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index < 0 || index >= labels.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[index],
                              textAlign: TextAlign.center,
                              style: MyStyle.title12(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine:
                        (value) => FlLine(
                          color: Theme.of(
                            context,
                          ).dividerColor.withOpacity(0.3),
                          strokeWidth: 1,
                        ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    statsData.length,
                    (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: statsData[index].toDouble(),
                          gradient: LinearGradient(
                            colors: gradientColors[index],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          width: 28,
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxValue * 1.2,
                            color: Theme.of(
                              context,
                            ).dividerColor.withOpacity(0.1),
                          ),
                        ),
                      ],
                      // showingTooltipIndicators: [0],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // chart legend
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                key.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          gradient: LinearGradient(
                            colors: gradientColors[index],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(key[index], style: MyStyle.title12(context)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
