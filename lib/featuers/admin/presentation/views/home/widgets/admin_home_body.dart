import 'package:flutter/material.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/admin/presentation/views/home/widgets/waste_card.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';

import '../../../../../../generated/l10n.dart'; // Assuming you have this custom widget

class AdminHomeBody extends StatelessWidget {
  const AdminHomeBody({super.key, required this.userData});
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    String getTimeOfDayGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) return S.of(context).good_morning;
      if (hour < 17) return S.of(context).good_afternoon;
      return S.of(context).good_evening;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Text(
                  getTimeOfDayGreeting(),
                  style: MyStyle.title18(
                    context,
                  ).copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  userData.name ?? 'Driver',
                  style: MyStyle.title25(context),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          SliverGrid.builder(
            itemCount: Constants.materials.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75, // Adjust card aspect ratio
            ),
            itemBuilder:
                (_, index) => WasteCard(
                  matrialName: Constants.materials[index]['name'],
                  description: Constants.materials[index]['desc'],
                ),
          ),
        ],
      ),
    );
  }
}
