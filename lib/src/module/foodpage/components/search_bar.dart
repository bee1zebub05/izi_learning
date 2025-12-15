import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/generated/assets.gen.dart';
import 'package:learning/generated/colors.gen.dart';
import 'package:learning/src/common/widget/app_text.dart';

class FoodSearchBar extends StatelessWidget {
  const FoodSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 18.h),
      child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.sp),
          color: ColorName.grayBackground,
          boxShadow: List.empty(),
        ),
        child: Row(
          spacing: 8.w,
          children: [
            SizedBox.shrink(),
            Assets.icons.icSearch.svg(height: 14.sp),
            AppText("Tìm cửa hàng hay sản phẩm", textColor: ColorName.grayText),
          ],
        ),
      ),
    );
  }
}
