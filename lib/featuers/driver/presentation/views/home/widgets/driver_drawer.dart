import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../../core/widgets/drawer_header.dart';
import '../../../../../auth/presentation/cubits/Auth/auth_cubit.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../../../user/presentation/views/home/widgets/my_list_tile.dart';

class DriverDrawer extends StatelessWidget {
  const DriverDrawer({super.key, required this.userData});
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
                MyDrawerHeader(userData: userData, routeName: 'driverProfile'),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.question_mark_rounded,
                  title: S.of(context).faqs,
                  onTap: () => _navigateTo(context, 'FAQs'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.info_rounded,
                  title: S.of(context).about_us,
                  onTap: () => _navigateTo(context, 'aboutUs'),
                ),
              ],
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: MyListTile(icon: icon, title: title, onTap: onTap),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 8),
          _buildMenuItem(
            context,
            icon: Icons.logout_rounded,
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
