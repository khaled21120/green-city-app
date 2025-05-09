import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/functions/helper.dart';
import '../../../../../../core/utils/text_style.dart';
import '../../../Cubits/Announs Cubit/announs_cubit.dart';

class UserAnnouns extends StatefulWidget {
  const UserAnnouns({super.key});

  @override
  State<UserAnnouns> createState() => _UserAnnounsState();
}

class _UserAnnounsState extends State<UserAnnouns> {
  final messageController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? binNumber, announcementType, region;
  File? data;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  void submitForm() async {
    // if (data == null) {
    //   return;
    // }
    if (_formKey.currentState!.validate()) {
      final user = Helper.getUser();
      context.read<AnnounsCubit>().sendAnnouncements(
        announcementType: announcementType!,
        binNumber: binNumber!,
        selectedDate: selectedDate,
        address: addressController.text,
        message: messageController.text,
        user: user,
        image: data,
      );
      messageController.clear();
      addressController.clear();
      setState(() {
        binNumber = null;
        announcementType = null;
        region = null;
        data = null;
      });
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
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
    return BlocListener<AnnounsCubit, AnnounsState>(
      listener: (context, state) {
        if (state is AnnounsSend) {
          Helper.showSnackBar(context: context, message: state.message);
        } else if (state is AnnounsError) {
          Helper.showSnackBar(context: context, message: state.message);
        }
      },
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

                // 📅 Date
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
                const SizedBox(height: 20),
                const Divider(),

                // 📦 Dropdowns
                Wrap(
                  spacing: 13,
                  runSpacing: 10,
                  children: [
                    _buildDropdown(
                      label: S.of(context).your_announcement_type,
                      value: announcementType,
                      items: Constants.announcementTypes,
                      onChanged:
                          (val) => setState(() => announcementType = val),
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

                const SizedBox(height: 24),

                // 📤 Submit
                Center(
                  child: MyButton(
                    text: S.of(context).submit,
                    onTap: submitForm,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔗 Social Icons
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.email, color: Colors.red),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
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
}
