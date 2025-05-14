import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/contact_card.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).contact_us)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),
            const SizedBox(height: 30),

            // Contact Methods
            _buildContactMethods(context),
            const SizedBox(height: 30),

            // Contact Form
            _buildContactForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('We\'d love to hear from you!', style: MyStyle.title20(context)),
        const SizedBox(height: 8),
        Text(
          'Reach out through any of these channels or send us a message directly.',
          style: MyStyle.title14(context).copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildContactMethods(BuildContext context) {
    return Column(
      children: [
        ContactCard(
          icon: FontAwesomeIcons.solidEnvelope,
          title: 'Email Us',
          subtitle: 'support@greencity.com',
          onTap: () => _launchEmail('support@greencity.com'),
        ),
        const SizedBox(height: 16),
        ContactCard(
          icon: FontAwesomeIcons.phone,
          title: 'Call Us',
          subtitle: '+1 (555) 123-4567',
          onTap: () => _launchPhone('+201208299594'),
        ),
        const SizedBox(height: 16),
        ContactCard(
          icon: FontAwesomeIcons.mapLocationDot,
          title: 'Visit Us',
          subtitle: '123 Green St, Eco City',
          onTap: () => _launchMaps('123 Green St, Eco City'),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send us a message', style: MyStyle.title20(context)),
          const SizedBox(height: 16),
          MyTextFelid(
            controller: nameController,
            label: S.of(context).name,
            icon: const Icon(Icons.person),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          MyTextFelid(
            controller: emailController,
            label: S.of(context).email,
            icon: const Icon(Icons.email),
          ),
          const SizedBox(height: 16),
          MyTextFelid(
            controller: messageController,
            maxLines: 5,
            label: S.of(context).message,
            icon: const Icon(Icons.message),
          ),
          const SizedBox(height: 20),
          Center(
            child: MyButton(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  _submitForm();
                }
              },
              text: S.of(context).submit_feedback,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchMaps(String address) async {
    final uri = Uri(scheme: 'geo:0,0?q=$address');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
