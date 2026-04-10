import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Product extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  final Function() onTap;

  const Product({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              width: 150,
              height: 120,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[350]!,
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 90,
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: const TextStyle(
                  fontFamily: 'Vogue Bold'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
