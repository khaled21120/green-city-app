import 'package:flutter/material.dart';

import '../../../../../../../core/utils/constants.dart';
import '../../../../../../../core/services/prefs_service.dart';
import '../../../../../../../core/utils/text_style.dart';
import '../../../../../../../generated/l10n.dart';
import 'widgets/info_card.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about_us),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📌 Logo or Image
              Image.asset(
                PrefsService.loadTheme() == 1
                    ? Constants.logoDark
                    : Constants.logo,
                width: width * 0.6,
                filterQuality: FilterQuality.high,
                semanticLabel: 'App Logo',
              ),

              // 🏙️ Title & Subtitle
              Text(
                S.of(context).welcome_message,
                textAlign: TextAlign.center,
                style: MyStyle.title30(context),
              ),
              const SizedBox(height: 10),

              Text(
                S.of(context).description,
                textAlign: TextAlign.center,
                style: MyStyle.title16(context),
              ),
              const SizedBox(height: 30),

              // 🎯 Our Mission Section
              InfoCard(
                icon: Icons.eco,
                title: S.of(context).our_mission,
                description: S.of(context).our_mission_description,
              ),

              // 🚀 Our Vision Section
              InfoCard(
                icon: Icons.visibility,
                title: S.of(context).our_vision,
                description: S.of(context).our_vision_description,
              ),

              // 🏆 Our Services Section
              InfoCard(
                icon: Icons.cleaning_services,
                title: S.of(context).our_services,
                description: S.of(context).our_services_description,
              ),

              // 📍 Contact Information Section
              InfoCard(
                icon: Icons.phone,
                title: S.of(context).contact_us,
                description: S.of(context).contact_us_description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
