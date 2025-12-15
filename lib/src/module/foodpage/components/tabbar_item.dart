import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/generated/assets.gen.dart';
import 'package:learning/generated/colors.gen.dart';
import 'package:learning/src/common/constants/ui_constant.dart';

class TabbarItem extends StatelessWidget {
  const TabbarItem({super.key, required this.icon});

  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: UIConst.defaultPadding / 10),
      child: Container(
        width: 28.sp,
        height: 28.sp,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorName.redLight,
        ),
        child: Center(
          child: icon.svg(
            width: 16.sp,
            height: 16.sp,
          ),
        ),
      ),
    );
  }
}
