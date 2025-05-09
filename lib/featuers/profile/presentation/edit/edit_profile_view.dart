import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/featuers/profile/cubit/profile_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/themes/light_theme.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/data/models/user_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
    required this.user,
    required this.phoneController,
    required this.addressController,
    required this.nameController,
  });
  final UserModel user;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    widget.nameController.text = widget.user.name ?? '';
    widget.phoneController.text = widget.user.phone ?? '';
    widget.addressController.text = widget.user.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).edit_profile)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateDataSuccess) {
            Helper.showSnackBar(
              context: context,
              message: 'Profile updated successfully!',
            );
            Navigator.pop(context);
          } else if (state is UpdateDataFailure) {
            Helper.showSnackBar(context: context, message: state.errMsg);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is FetchDataLoading,
            opacity: 0.4,
            progressIndicator: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    MyTextFelid(
                      label: S.of(context).name,
                      controller: widget.nameController,
                    ),
                    const SizedBox(height: 24),
                    MyTextFelid(
                      label: S.of(context).phone_number,
                      controller: widget.phoneController,
                    ),
                    const SizedBox(height: 24),
                    MyTextFelid(
                      label: S.of(context).address,
                      controller: widget.addressController,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(S.of(context).update),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await context.read<ProfileCubit>().updateData(
        data: {
          'Name': widget.nameController.text,
          'Phone': widget.phoneController.text,
          'Address': widget.addressController.text,
        },
        isImage: false,
      );
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
