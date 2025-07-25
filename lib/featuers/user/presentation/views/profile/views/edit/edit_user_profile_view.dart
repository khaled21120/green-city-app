import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/widgets/button.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/featuers/user/presentation/cubits/profile/profile_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../../core/themes/light_theme.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../auth/data/models/user_model.dart';

class EditUserProfileView extends StatefulWidget {
  const EditUserProfileView({super.key, required this.user});
  final UserModel user;

  @override
  State<EditUserProfileView> createState() => _EditUserProfileViewState();
}

class _EditUserProfileViewState extends State<EditUserProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data
    _nameController = TextEditingController(text: widget.user.name ?? '');
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _addressController = TextEditingController(text: widget.user.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).edit_profile)),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen:
            (previous, current) =>
                current is FetchDataLoading ||
                current is UpdateDataSuccess ||
                current is UpdateDataFailure,
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
                    MyTextField(
                      icon: const Icon(FontAwesomeIcons.solidUser),
                      label: S.of(context).name,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 24),
                    MyTextField(
                      icon: const Icon(FontAwesomeIcons.phone),
                      label: S.of(context).phone_number,
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 24),
                    MyTextField(
                      icon: const Icon(FontAwesomeIcons.locationDot),
                      label: S.of(context).address,
                      controller: _addressController,
                    ),
                    const SizedBox(height: 32),
                    MyButton(
                      onTap: () {
                        _isLoading ? null : _submitForm();
                      },
                      text: S.of(context).update,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => _isLoading = true);

    await context
        .read<ProfileCubit>()
        .updateProfile(
          data: {
            'Name': _nameController.text.trim(),
            'Phone': _phoneController.text.trim(),
            'Address': _addressController.text.trim(),
          },
          isImage: false,
        )
        // ignore: use_build_context_synchronously
        .then((val) => Navigator.pop(context));
  }
}
