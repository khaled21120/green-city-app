import 'package:flutter/material.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/generated/l10n.dart';

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
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  void submitForm() {
    // Handle form submission logic
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform actions
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
    phoneController.dispose();
    addressController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).announcements)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Name Text Felid
                MyTextFelid(
                  controller: nameController,
                  label: S.of(context).name,
                ),

                // Email Text Felid
                MyTextFelid(
                  controller: emailController,
                  label: S.of(context).email,
                ),

                // Phone Number Text Felid
                MyTextFelid(
                  label: S.of(context).phone_number,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),

                // Address Text Felid
                MyTextFelid(
                  label: S.of(context).address,
                  controller: addressController,
                  maxLines: 2,
                ),

                // Message Text Felid
                MyTextFelid(
                  controller: messageController,
                  label: S.of(context).message,
                  maxLines: 3,
                ),

                // 📤 Submit Button
                MyButton(
                  text: S.of(context).submit,
                  onTap: () {
                    submitForm();
                  },
                ),

                // 🔗 Social Media Links
                Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
