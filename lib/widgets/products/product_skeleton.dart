import 'package:flutter/material.dart';
import 'package:flutter_music/utils/random_int.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[350]!,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 80,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: RandomInt.generate(min: 60, max: 120).toDouble(),
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: RandomInt.generate(min: 60, max: 120).toDouble(),
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: RandomInt.generate(min: 60, max: 120).toDouble(),
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
          ),
        ],
      )
    );
  }
}
