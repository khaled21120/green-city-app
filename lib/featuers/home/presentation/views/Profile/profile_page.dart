import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/services/get_it_service.dart';
import 'package:green_city/featuers/home/domain/repo/home_repo.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/functions/helper.dart';
import '../../../../../core/utils/text_style.dart';
import '../../Cubits/Profile Cuibt/profile_cubit.dart';
import 'widgets/profile_item.dart';
import 'widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<HomeRepo>()),
      child: Scaffold(
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateDataFailure) {
              Helper.showSnackBar(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            // final user =
            //     state is ProfileUpdateDataSuccess
            //         ? state.userApiModel
            //         : Helper.getUser();
            return ModalProgressHUD(
              inAsyncCall: state is ProfileLoading ? true : false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Picture
                    const ProfilePicture(),
                    const SizedBox(height: 10),

                    // User Name
                    Text(
                      // user.name ?? 
                      S.of(context).user_name,
                      textAlign: TextAlign.center,
                      style: MyStyle.title25(context),
                    ),

                    // User Email
                    Text(
                      // user.email ?? 
                      S.of(context).email_address,
                      textAlign: TextAlign.center,
                      style: MyStyle.title16(context),
                    ),
                    const SizedBox(height: 10),

                    // User Details
                    ProfileItem(
                      icon: Icons.phone,
                      title:
                      //  user.phone ?? 
                       S.of(context).change_phone_number,
                      onTap: () {
                        Helper.showAlert(
                          context: context,
                          leftFunc: () async {
                            if (phoneController.text.isNotEmpty) {
                              await context.read<ProfileCubit>().updateData(
                                data: {'Phone': phoneController.text},
                              );
                            }
                            phoneController.clear();
                          },
                          title: S.of(context).phone_number,
                          controller: phoneController,
                        );
                      },
                    ),
                    ProfileItem(
                      icon: Icons.location_on,
                      title:
                      //  user.address ?? 
                       S.of(context).change_address,
                      onTap: () {
                        Helper.showAlert(
                          context: context,
                          leftFunc: () async {
                            if (addressController.text.isNotEmpty) {
                              await context.read<ProfileCubit>().updateData(
                                data: {'Address': addressController.text},
                              );
                            }
                            addressController.clear();
                          },
                          title: S.of(context).address,
                          controller: addressController,
                        );
                      },
                    ),
                    ProfileItem(
                      icon: Icons.settings,
                      title: S.of(context).settings,
                      onTap: () => GoRouter.of(context).push('/settings'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
