import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/assets.gen.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.color = const Color.fromRGBO(0, 0, 0, 0.5), // Sửa ở đây
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lottie.loading,
              repeat: true,
              width: 220.w,
              height: 220.w,
            ),
          ],
        ),
      ),
    );
  }
}
