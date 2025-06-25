import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/widgets/drawer_header.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../../../../core/widgets/my_list_tile.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key, required this.userData});
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                MyDrawerHeader(userData: userData, routeName: 'userProfile'),
                const SizedBox(height: 16),
                ..._buildMenuItems(context),
              ],
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    return [
      _buildMenuItem(
        context,
        icon: FontAwesomeIcons.circleQuestion,
        title: S.of(context).faqs,
        routeName: 'FAQs',
      ),
      _buildMenuItem(
        context,
        icon: FontAwesomeIcons.solidBell,
        title: S.of(context).notifications,
        routeName: 'notifications',
      ),
      _buildMenuItem(
        context,
        icon: FontAwesomeIcons.solidCalendar,
        title: S.of(context).my_Activities,
        routeName: 'myActivities',
      ),
      _buildMenuItem(
        context,
        icon: FontAwesomeIcons.solidEnvelope,
        title: S.of(context).contact_us,
        routeName: 'contactUs',
      ),
      _buildMenuItem(
        context,
        icon: FontAwesomeIcons.info,
        title: S.of(context).about_us,
        routeName: 'aboutUs',
      ),
    ];
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String routeName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: MyListTile(
        icon: icon,
        title: title,
        onTap: () => _navigateTo(context, routeName),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 8),
          MyListTile(
            icon: FontAwesomeIcons.rightFromBracket,
            title: S.of(context).sign_out,
            onTap: () => context.read<AuthCubit>().logOut(),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) =>
      GoRouter.of(context).pushNamed(routeName);
}
