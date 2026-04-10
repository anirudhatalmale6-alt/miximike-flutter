import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/random_int.dart';

class TrackSkeleton extends StatelessWidget {
  const TrackSkeleton({super.key,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[350]!,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: RandomInt.generate(min: 120, max: 170).toDouble(),
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
            ),
            const Spacer(),
            Container(
              width: 30,
              height: 30,
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
