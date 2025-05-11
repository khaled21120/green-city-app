import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridItem extends StatelessWidget {
  const ShimmerGridItem({super.key, required this.aspectratio});
  final double aspectratio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspectratio,
      ),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[600]!,
          highlightColor: Colors.grey[400]!,
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(height: 40, color: Colors.grey),
                  const SizedBox(height: 8),
                  Container(height: 20, color: Colors.grey),
                  const SizedBox(height: 12),
                  Container(height: 20, width: 50, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
