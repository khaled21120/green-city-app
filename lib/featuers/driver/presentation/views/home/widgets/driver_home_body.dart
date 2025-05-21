import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/core/widgets/home_card.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/driver/presentation/views/home/widgets/driver_drawer.dart';
import 'package:green_city/featuers/driver/presentation/views/home/widgets/driver_stats.dart';
import 'package:green_city/generated/l10n.dart';

class DriverHomeBody extends StatelessWidget {
  const DriverHomeBody({super.key, required this.userData});
  final UserModel userData;

  String _getTimeOfDayGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return S.of(context).good_morning;
    if (hour < 17) return S.of(context).good_afternoon;
    return S.of(context).good_evening;
  }

  List<Map<String, dynamic>> _getFeatureItems(BuildContext context) {
    return [
      {
        'icon': FontAwesomeIcons.solidClipboard,
        'title': S.of(context).todays_tasks,
        'color': Colors.blueAccent[400]!,
        'route': 'todayTasks',
      },
      {
        'icon': FontAwesomeIcons.solidHourglassHalf,
        'title': S.of(context).pending_tasks,
        'color': Colors.orangeAccent[400]!,
        'route': 'pendingTasks',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final features = _getFeatureItems(context);
    final completedTasks = userData.numberOfCompletedTasks ?? 0;
    final totalTasks = 50; // Consider making this dynamic if possible
    final progressPercent = completedTasks / totalTasks;

    return Scaffold(
      key: scaffoldKey,
      drawer: DriverDrawer(userData: userData),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menu',
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                tooltip: S.of(context).profile,
                onPressed:
                    () => GoRouter.of(context).pushNamed('driverProfile'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(
                start: 72,
                bottom: 16,
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTimeOfDayGreeting(context),
                    style: MyStyle.title16(context).copyWith(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    userData.name ?? S.of(context).driver,
                    style: MyStyle.title20(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade700, Colors.teal.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            sliver: SliverToBoxAdapter(
              child: DriverStats(
                completedTasks: completedTasks,
                totalTasks: totalTasks,
                progressPercent: progressPercent,
                userData: userData,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final feature = features[index];
                return HomeCard(
                  data: feature,
                  onTap:
                      () => GoRouter.of(
                        context,
                      ).pushNamed(feature['route'] as String),
                );
              }, childCount: features.length),
            ),
          ),
        ],
      ),
    );
  }
}
