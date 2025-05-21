import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridItem extends StatelessWidget {
  const ShimmerGridItem({
    super.key,
    required this.aspectRatio,
    this.itemCount = 10,
  });

  final double aspectRatio;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder:
          (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[600]!,
            highlightColor: Colors.grey[400]!,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(height: 40, borderRadius: 8),
                    const SizedBox(height: 8),
                    _shimmerBox(height: 20, borderRadius: 8),
                    const SizedBox(height: 12),
                    _shimmerBox(height: 20, width: 50, borderRadius: 8),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _shimmerBox({
    required double height,
    double? width,
    double borderRadius = 4,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
