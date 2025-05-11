import 'package:flutter/material.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/featuers/admin/home/widgets/waste_card.dart'; // Assuming you have this custom widget

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount:
              Constants
                  .materials
                  .length, // Replace with your actual data length
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8, // Adjust card aspect ratio
          ),
          itemBuilder:
              (context, index) => WasteCard(
                matrialName: Constants.materials[index]['name'],
                description: Constants.materials[index]['desc'],
              ),
        ),
      ),
    );
  }
}
