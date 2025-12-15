import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:learning/src/common/widget/app_text.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/colors.gen.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({super.key, this.message, this.child});
  final String? message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          Assets.lottie.empty,
          repeat: false,
          fit: BoxFit.contain,
          width: 250.w,
          height: 250.h,
        ),
        AppText(
          message ?? 'Not found',
          textColor: ColorName.purple969,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        child ?? const SizedBox.shrink(),
      ],
    );
  }
}
