import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/admin/presentation/views/home/widgets/admin_drawer.dart';
import 'package:green_city/featuers/admin/presentation/views/home/widgets/waste_card.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/generated/l10n.dart';

class AdminHomeBody extends StatelessWidget {
  const AdminHomeBody({super.key, required this.userData});
  final UserModel userData;

  String _getTimeOfDayGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return S.of(context).good_morning;
    if (hour < 17) return S.of(context).good_afternoon;
    return S.of(context).good_evening;
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: AdminDrawer(userData: userData),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            expandedHeight: 120,
            collapsedHeight: 70,
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
                onPressed: () => GoRouter.of(context).pushNamed('adminProfile'),
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
                    userData.name ?? S.of(context).admin,
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
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final material = Constants.materials[index];
                return WasteCard(
                  matrialName: material['name'],
                  description: material['desc'],
                );
              }, childCount: Constants.materials.length),
            ),
          ),
        ],
      ),
    );
  }
}
