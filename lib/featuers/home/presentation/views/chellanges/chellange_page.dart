import 'package:flutter/material.dart';

import '../../../data/models/activities_model.dart';
import 'widgets/grid_item.dart';

class ChellangePage extends StatelessWidget {
  const ChellangePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ActivitiesModel> activities = [
      const ActivitiesModel(
        actName: 'reports',
        actDescription: 'send reports',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 15,
        numOfRequiredSubscribers: 30,
      ),
      const ActivitiesModel(
        actName: 'another reports',
        actDescription: ' adsdfaf reports',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 10,
        numOfRequiredSubscribers: 55,
      ),
      const ActivitiesModel(
        actName: 'fadv',
        actDescription: 'adfwffw reportvgvgvgvgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggs',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 19,
        numOfRequiredSubscribers: 60,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 20,
        numOfRequiredSubscribers: 30,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: ' not available',
        numOfSubscribers: 60,
        numOfRequiredSubscribers: 60,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 20,
        numOfRequiredSubscribers: 30,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 20,
        numOfRequiredSubscribers: 30,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 20,
        numOfRequiredSubscribers: 30,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 20,
        numOfRequiredSubscribers: 30,
      ),
      const ActivitiesModel(
        actName: 'nnnfd',
        actDescription: 'send bbwefqwe',
        actIntervalDate: '19/2/2025 - 27/2/2025',
        actstate: 'متاحة',
        numOfSubscribers: 20,
        numOfRequiredSubscribers: 30,
      ),
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        childAspectRatio: width / (height / 1.5),
        children: List.generate(
          activities.length,
          (idx) => GridItem(activitiesModel: activities[idx]),
        ),
      ),
    );
  }
}
