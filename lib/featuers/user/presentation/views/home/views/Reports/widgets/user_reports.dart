// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/themes/light_theme.dart';
import 'package:green_city/core/widgets/button.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../core/utils/text_style.dart';
import '../../../../../cubits/User Report Cubit/user_reports_cubit.dart';

class UserReports extends StatefulWidget {
  const UserReports({super.key});

  @override
  State<UserReports> createState() => _UserReportsState();
}

class _UserReportsState extends State<UserReports> {
  final messageController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? binNumber, reportType, region;
  File? image;
  bool isLoading = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  void submitForm() async {
    if (image == null) {
      Helper.showSnackBar(context: context, message: 'Please select an image');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final user = Helper.getUser();
      context.read<UserReportsCubit>().sendReports(
        announcementType: reportType!,
        binNumber: binNumber!,
        selectedDate: selectedDate,
        region: region!,
        address: addressController.text,
        message: messageController.text,
        user: user,
        image: image!,
      );
      messageController.clear();
      addressController.clear();
      setState(() {
        binNumber = null;
        reportType = null;
        region = null;
        image = null;
      });
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> pickImage(bool isCamera) async {
    try {
      setState(() => isLoading = true);
      final file = await Helper.pickImage(isCamera: isCamera);
      if (!mounted) return;

      if (file != null) {
        setState(() => image = file);
      } else {
        Helper.showSnackBar(context: context, message: 'No image selected');
      }
    } catch (e) {
      Helper.showSnackBar(context: context, message: 'Error picking image');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is ReportsSend) {
          Helper.showSnackBar(context: context, message: state.message);
        } else if (state is ReportsError) {
          Helper.showSnackBar(context: context, message: state.message);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📍 Address & 📩 Message
                  MyTextFelid(
                    controller: addressController,
                    label: S.of(context).address,
                    icon: const Icon(Icons.location_on),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  MyTextFelid(
                    controller: messageController,
                    label: S.of(context).message,
                    icon: const Icon(Icons.message),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),

                  // Date & Image
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: MyColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        Row(
                          spacing: 6,
                          children: [
                            Text(
                              S.of(context).select_date,
                              style: MyStyle.title16(context),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat.yMd().format(selectedDate),
                              style: MyStyle.title16(context),
                            ),
                            IconButton.filled(
                              style: IconButton.styleFrom(elevation: 8),
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  setState(() => selectedDate = date);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          spacing: 6,
                          children: [
                            Text(
                              S.of(context).upload_image,
                              style: MyStyle.title16(context),
                            ),
                            const Spacer(),
                            Text(
                              image == null
                                  ? S.of(context).no_image
                                  : image!.path.split('/').last,
                              style: MyStyle.title16(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton.filled(
                              style: IconButton.styleFrom(elevation: 8),
                              icon: const Icon(FontAwesomeIcons.camera),
                              onPressed: () => _showImagePickerOptions(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),

                  // 📦 Dropdowns
                  Wrap(
                    spacing: 13,
                    runSpacing: 10,
                    children: [
                      _buildDropdown(
                        label: S.of(context).your_report_type,
                        value: reportType,
                        items: Constants.announcementTypes,
                        onChanged: (val) => setState(() => reportType = val),
                      ),
                      _buildDropdown(
                        label: S.of(context).your_bin_number,
                        value: binNumber,
                        items: Constants.binNumbers,
                        onChanged: (val) => setState(() => binNumber = val),
                      ),
                      _buildDropdown(
                        label: S.of(context).your_region,
                        value: region,
                        items: Constants.regions,
                        onChanged: (val) => setState(() => region = val),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 📤 Submit
                  Center(
                    child: MyButton(
                      text: S.of(context).submit,
                      onTap: submitForm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return '${S.of(context).please_select} $label';
          }
          return null;
        },
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        items:
            items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: Text(S.of(context).camera),
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(true);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(S.of(context).gallery),
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(false);
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
