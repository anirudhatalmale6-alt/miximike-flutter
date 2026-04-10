import 'package:flutter/material.dart';

class Artist extends StatelessWidget {
  final String img1;
  final String title;
  final String subTitle;
  final Function() onTap;

  const Artist({
    super.key,
    required this.onTap,
    required this.img1,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
              img1,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontFamily: 'Vogue Bold',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
