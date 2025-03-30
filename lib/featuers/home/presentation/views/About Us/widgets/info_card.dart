import 'package:flutter/material.dart';

import '../../../../../../core/utils/text_style.dart';
import '../../../../../../core/themes/light_theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: MyColors.primary),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyStyle.title18(context),
                  ),
                  const SizedBox(height: 5),
                  Text(description, style: MyStyle.title14(context),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
