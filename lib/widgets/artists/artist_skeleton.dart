import 'package:flutter/material.dart';
import 'package:flutter_music/utils/random_int.dart';
import 'package:shimmer/shimmer.dart';

class ArtistSkeleton extends StatelessWidget {
  const ArtistSkeleton({super.key,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[350]!,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 50,
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
            width: 100,
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
            width: RandomInt.generate(min: 60, max: 100).toDouble(),
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
            width: RandomInt.generate(min: 60, max: 100).toDouble(),
            height: 10,
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
