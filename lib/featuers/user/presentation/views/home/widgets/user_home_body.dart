import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/core/widgets/home_card.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/user/presentation/views/home/widgets/user_charts.dart';
import 'package:green_city/featuers/user/presentation/views/home/widgets/user_drawer.dart';
import 'package:green_city/generated/l10n.dart';

class UserHomeBody extends StatelessWidget {
  const UserHomeBody({super.key, required this.userData});
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
        'icon': FontAwesomeIcons.solidChartBar,
        'title': S.of(context).polls,
        'color': Colors.orangeAccent,
        'route': 'polls',
      },
      {
        'icon': FontAwesomeIcons.solidNewspaper,
        'title': S.of(context).view_my_reports,
        'color': Colors.blueAccent,
        'route': 'myReports',
      },
      {
        'icon': FontAwesomeIcons.solidMap,
        'title': S.of(context).report_location,
        'color': Colors.indigoAccent,
        'route': 'reports',
      },
      {
        'icon': FontAwesomeIcons.solidCalendar,
        'title': S.of(context).activities,
        'color': Colors.tealAccent[400]!,
        'route': 'activities',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final features = _getFeatureItems(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: UserDrawer(userData: userData),
      floatingActionButton: FloatingActionButton(
        heroTag: 'assistantButton',
        onPressed:
            () => GoRouter.of(
              context,
            ).pushNamed('assistantPage', extra: userData),
        child: const Icon(FontAwesomeIcons.robot),
      ),
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
                onPressed: () => GoRouter.of(context).pushNamed('userProfile'),
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
                    style: MyStyle.title14(context).copyWith(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    userData.name ?? S.of(context).name,
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
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                UserStatsBarChart(userData: userData),
                const SizedBox(height: 24),
                Text(S.of(context).features, style: MyStyle.title30(context)),
              ]),
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
          const SliverToBoxAdapter(
            child: SizedBox(height: 80), // Space for FAB
          ),
        ],
      ),
    );
  }
}
