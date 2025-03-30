import 'package:flutter/material.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../data/models/activities_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.activitiesModel});
  final ActivitiesModel activitiesModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(activitiesModel.actName!)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(activitiesModel.actDescription!),
              Text(activitiesModel.actIntervalDate!),
              Text(activitiesModel.actstate!),
              Text(activitiesModel.numOfSubscribers.toString()),
              Text(activitiesModel.numOfRequiredSubscribers.toString()),
              MyButton(text: S.of(context).join, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
