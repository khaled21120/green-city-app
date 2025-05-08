import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/featuers/home/data/models/announs_model.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/text_style.dart';
import '../../Cubits/Announs Cubit/announs_cubit.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? binNumber, announcementType, region;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  void submitForm() {
    // Handle form submission logic
    if (_formKey.currentState!.validate()) {
      final announsModel = AnnounsModel(
        userName: nameController.text,
        email: emailController.text,
        announcementType: announcementType,
        announcementDescription: messageController.text,
        binNumber: binNumber,
        region: region,
        siteLocation: addressController.text,
        todayDate: DateFormat.yMd('en').format(selectedDate),
      );
      context.read<AnnounsCubit>().sendAnnouncements(announsModel);
    } else {
      // Form is invalid, show error messages
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).announcements)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // 👤 Name & Email
                MyTextFelid(
                  controller: nameController,
                  label: S.of(context).name,
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(height: 12),
                MyTextFelid(
                  controller: emailController,
                  label: S.of(context).email,
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(height: 12),

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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
