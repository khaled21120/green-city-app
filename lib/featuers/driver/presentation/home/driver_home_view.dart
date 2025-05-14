import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/driver/presentation/home/widgets/driver_stats.dart';
import 'package:green_city/featuers/user/home/presentation/widgets/home_card.dart';

import '../../../../core/functions/helper.dart';

class DriverHomeView extends StatelessWidget {
  const DriverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': FontAwesomeIcons.solidClipboard,
        'title': 'Today\'s Tasks',
        'color': Colors.blueAccent[400]!,
      },
      {
        'icon': FontAwesomeIcons.solidHourglassHalf,
        'title': 'Pending Tasks',
        'color': Colors.orangeAccent[400]!,
      },
    ];
    final userData = Helper.getUser();
    final completedTasks = 40;
    final totalTasks = 50;
    final progressPercent = completedTasks / totalTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Green City'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => GoRouter.of(context).pushNamed('driverProfile'),
          ),
        ],
      ),
      body: Padding(
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
      ),
    );
  }
}
