import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/themes/dark_theme.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../../../user/presentation/cubits/profile/profile_cubit.dart';
import '../../../../../user/presentation/views/profile/widgets/header.dart';
import '../../../../../user/presentation/views/profile/widgets/options.dart';

class AdminProfileBody extends StatefulWidget {
  const AdminProfileBody({super.key});

  @override
  State<AdminProfileBody> createState() => _AdminProfileBodyState();
}

class _AdminProfileBodyState extends State<AdminProfileBody> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
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
        final cubit = context.read<ProfileCubit>();
        final user = cubit.currentUser;
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
                ProfileOptions(user: user),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
