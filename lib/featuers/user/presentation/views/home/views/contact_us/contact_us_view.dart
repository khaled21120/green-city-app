import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/widgets/button.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/user/data/models/contact_us_model.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/utils/helper.dart';
import '../../../../cubits/contact_us/contact_us_cubit.dart';
import 'widgets/contact_card.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).contact_us)),
      body: BlocListener<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          if (state is ContactUsError) {
            Helper.showSnackBar(context: context, message: state.message);
          }
          if (state is ContactUsSuccess) {
            Helper.showSnackBar(context: context, message: state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),

              // Contact Methods
              _buildContactMethods(context),

              // Contact Form
              _buildContactForm(context),
            ],
          ),
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
          MyTextField(
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
      final userData = Helper.getUser();
      final feedback = ContactUsModel(
        name: userData.name,
        email: userData.email,
        message: messageController.text.trim(),
      );
      context.read<ContactUsCubit>().sendFeedback(feedback);
      _resetForm();
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }

  void _resetForm() {
    setState(() {
      messageController.clear();
    });
  }
}
