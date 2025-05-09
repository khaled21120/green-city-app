import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/functions/helper.dart';
import '../../../../core/themes/dark_theme.dart';
import '../../../auth/data/models/user_model.dart';
import '../../cubit/profile_cubit.dart';
import 'header.dart';
import 'options.dart';
import 'stats.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is FetchDataFailure) {
          Helper.showSnackBar(context: context, message: state.errMsg);
        } else if (state is UpdateDataSuccess) {
          Helper.showSnackBar(
            context: context,
            message: 'Profile updated successfully!',
          );
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else if (state is UpdateDataFailure) {
          Helper.showSnackBar(context: context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        log("Current state: $state");
        final cubit = context.read<ProfileCubit>();
        final user = cubit.currentUser;

        if (user != null) {
          _phoneController.text = user.phone ?? '';
          _addressController.text = user.address ?? '';
        }
        return ModalProgressHUD(
          inAsyncCall: state is FetchDataLoading,
          opacity: 0.4,
          progressIndicator: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
          ),
          child: _buildContent(state, user, context),
        );
      },
    );
  }

  Widget _buildContent(
    ProfileState state,
    UserModel? user,
    BuildContext context,
  ) {
    if (state is FetchDataFailure) {
      return Center(child: Text(state.errMsg));
    }

    return RefreshIndicator(
      onRefresh: () async => context.read<ProfileCubit>().fetchUserData(),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              if (user != null) ...[
                ProfileHeader(user: user),
                const SizedBox(height: 24),
                ProfileStats(user: user),
                const SizedBox(height: 24),
                ProfileOptions(
                  user: user,
                  phoneController: _phoneController,
                  addressController: _addressController,
                  nameController: _nameController,
                ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
