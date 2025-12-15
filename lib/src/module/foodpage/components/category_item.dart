import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/src/common/widget/app_text.dart';
import 'package:learning/src/module/foodpage/model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 52.h,
          width: 52.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(52.sp),
            child: Image.network(category.thumbnail, fit: BoxFit.cover),
          ),
        ),
        AppText(category.name)
      ],
    );
  }
}
