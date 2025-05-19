import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/widgets/button.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/featuers/user/presentation/cubits/Profile%20Cubit/profile_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../../core/themes/light_theme.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../auth/data/models/user_model.dart';

class EditDriverProfileView extends StatefulWidget {
  const EditDriverProfileView({super.key, required this.user});
  final UserModel user;

  @override
  State<EditDriverProfileView> createState() => _EditDriverProfileViewState();
}

class _EditDriverProfileViewState extends State<EditDriverProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _licenseController;
  late final TextEditingController _licenseExpiryController;
  late final TextEditingController _truckNumberController;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data
    _nameController = TextEditingController(text: widget.user.name ?? '');
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _addressController = TextEditingController(text: widget.user.address ?? '');
    _truckNumberController = TextEditingController(
      text: widget.user.truckNumber ?? '',
    );
    _licenseController = TextEditingController(
      text: widget.user.licenseNumber ?? '',
    );
    _licenseExpiryController = TextEditingController(
      text: widget.user.licenseExpiryDate ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _truckNumberController.dispose();
    _licenseController.dispose();
    _licenseExpiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).edit_profile)),
      body: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) => current is! ProfileStateInitial,
        listener: (context, state) {
          if (state is UpdateDataSuccess) {
            _handleUpdateSuccess(context);
          } else if (state is UpdateDataFailure) {
            _handleUpdateFailure(context, state);
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
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
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    label: S.of(context).name,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 24),
                  MyTextFelid(
                    icon: const Icon(FontAwesomeIcons.phone),
                    label: S.of(context).phone_number,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 24),
                  MyTextFelid(
                    icon: const Icon(FontAwesomeIcons.locationDot),
                    label: S.of(context).address,
                    controller: _addressController,
                  ),
                  const SizedBox(height: 24),
                  MyTextFelid(
                    icon: const Icon(FontAwesomeIcons.truckPickup),
                    label: S.of(context).truck_number,
                    keyboardType: TextInputType.number,
                    controller: _truckNumberController,
                  ),
                  const SizedBox(height: 24),
                  MyTextFelid(
                    // ignore: deprecated_member_use
                    icon: const Icon(FontAwesomeIcons.solidDriversLicense),
                    label: S.of(context).license_number,
                    keyboardType: TextInputType.number,
                    controller: _licenseController,
                  ),
                  const SizedBox(height: 24),
                  MyTextFelid(
                    icon: const Icon(FontAwesomeIcons.calendarDays),
                    label: S.of(context).license_expiry_date,
                    controller: _licenseExpiryController,
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
        ),
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => _isLoading = true);

    await context.read<ProfileCubit>().updateData(
      data: {
        'Name': _nameController.text,
        'Phone': _phoneController.text,
        'Address': _addressController.text,
        'TruckNumber': _truckNumberController.text,
        'LicenseNumber': _licenseController.text,
        'LicenseExpiryDate': _licenseExpiryController.text,
      },
      isImage: false,
    );
  }

  void _handleUpdateSuccess(BuildContext context) {
    setState(() => _isLoading = false);
    Helper.showSnackBar(
      context: context,
      message: 'Profile updated successfully!',
    );
    Navigator.pop(context);
  }

  void _handleUpdateFailure(BuildContext context, UpdateDataFailure state) {
    setState(() => _isLoading = false);
    Helper.showSnackBar(context: context, message: state.errMsg);
  }
}
