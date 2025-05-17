import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';

import '../../../../../generated/l10n.dart';
import '../../../../user/home/presentation/widgets/home_card.dart';
import 'driver_stats.dart';

class DriverHomeBody extends StatelessWidget {
  const DriverHomeBody({super.key, required this.userData});
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': FontAwesomeIcons.solidClipboard,
        'title': S.of(context).todays_tasks,
        'color': Colors.blueAccent[400]!,
      },
      {
        'icon': FontAwesomeIcons.solidHourglassHalf,
        'title': S.of(context).pending_tasks,
        'color': Colors.orangeAccent[400]!,
      },
    ];
    final completedTasks = 35;
    final totalTasks = 50;
    final progressPercent = completedTasks / totalTasks;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DriverStats(
              completedTasks: completedTasks,
              totalTasks: totalTasks,
              progressPercent: progressPercent,
              userData: userData,
            ),
          ),
          SliverGrid.builder(
            itemCount: features.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder:
                (_, i) => HomeCard(
                  data: features[i],
                  onTap: () {
                    // switch (i) {
                    //   case 0:
                    //     GoRouter.of(context).pushNamed('polls');
                    //     break;
                    //   case 1:
                    //     GoRouter.of(context).pushNamed('myAnnouncements');
                    //     break;
                    // }
                  },
                ),
          ),
        ],
      ),
    );
  }
}
