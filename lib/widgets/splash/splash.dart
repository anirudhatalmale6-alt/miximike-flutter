import 'package:flutter/material.dart';
import 'package:flutter_music/utils/theme.dart';

class Splash extends StatelessWidget {
  const Splash({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
          ),
          // const SpinKitWave(
          //   color: AppTheme.lightSecondaryColor,
          //   type: SpinKitWaveType.center,
          // )
        ],
      ),
    );
  }
}
