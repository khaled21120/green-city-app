import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/functions/helper.dart';
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
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateDataFailure) {
          Helper.showSnackBar(context: context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        final user = context.watch<ProfileCubit>().currentUser;
        return ModalProgressHUD(
          inAsyncCall: state is ProfileLoading,
          child:
              user == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                      spacing: 15,
                      children: [
                        const SizedBox(height: 20),
                        ProfileHeader(user: user),
                        ProfileStats(user: user),
                        ProfileOptions(
                          user: user,
                          phoneController: phoneController,
                          addressController: addressController,
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
