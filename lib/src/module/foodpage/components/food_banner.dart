import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodBanner extends StatelessWidget {
  const FoodBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        height: 132.h,
        width: 315.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.sp),
          child: Image.network(
            "https://imgsrv.crunchyroll.com/cdn-cgi/image/fit=contain,format=auto,quality=70,width=1200,height=675/catalog/crunchyroll/bda784a1ce5094330e7fa23d3da33eca.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
