import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/text_style.dart';

class WasteCard extends StatelessWidget {
  const WasteCard({
    super.key,
    required this.matrialName,
    required this.description,
  });
  final String matrialName, description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed('wasteDetails', extra: matrialName);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Waste Type
              Text(matrialName, style: MyStyle.title18(context)),

              // Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: MyStyle.title14(context).copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
