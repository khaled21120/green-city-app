import 'package:flutter/material.dart';

import '../../../../../core/utils/text_style.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.data, required this.onTap});
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = data['title'] as String;
    final color = data['color'] as Color;
    final icon = data['icon'] as IconData;
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .2),
                  shape: BoxShape.circle,
                ),

                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: MyStyle.title18(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
