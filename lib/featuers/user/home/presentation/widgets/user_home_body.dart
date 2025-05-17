import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/user/home/presentation/widgets/home_card.dart';
import 'package:green_city/generated/l10n.dart';

class UserHomeBody extends StatelessWidget {
  const UserHomeBody({super.key, required this.userData});
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    String getTimeOfDayGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) return S.of(context).good_morning;
      if (hour < 17) return S.of(context).good_afternoon;
      return S.of(context).good_evening;
    }

    final List<Map<String, dynamic>> features = [
      {
        'icon': FontAwesomeIcons.solidChartBar, // Updated to solid style
        'title': S.of(context).polls,
        'color': Colors.indigoAccent,
      },
      {
        'icon': FontAwesomeIcons.solidNewspaper,
        'title': S.of(context).view_my_reports,
        'color': Colors.blueAccent,
      },
      {
        'icon': FontAwesomeIcons.solidMap,
        'title': S.of(context).report_location,
        'color': Colors.orangeAccent,
      },
      {
        'icon': FontAwesomeIcons.solidCalendar,
        'title': S.of(context).activities,
        'color': Colors.tealAccent[400]!,
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  Text(
                    getTimeOfDayGreeting(),
                    style: MyStyle.title18(
                      context,
                    ).copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userData.name ?? 'Driver',
                    style: MyStyle.title25(context),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // Feature Buttons
            SliverGrid.builder(
              itemCount: features.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder:
                  (_, index) => HomeCard(
                    data: features[index],
                    onTap: () {
                      switch (index) {
                        case 0:
                          GoRouter.of(context).pushNamed('polls');
                          break;
                        case 1:
                          GoRouter.of(context).pushNamed('myReports');
                          break;
                        case 2:
                          GoRouter.of(context).pushNamed('reports');
                          break;
                        case 3:
                          GoRouter.of(context).pushNamed('activities');
                          break;
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('assistantPage', extra: userData);
        },
        child: const Icon(FontAwesomeIcons.bots),
      ),
    );
  }
}
