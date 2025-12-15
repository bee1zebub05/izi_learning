import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/src/common/constants/ui_constant.dart';

import '../../../../generated/colors.gen.dart';
import 'app_button.dart';
import 'app_dialog.dart';
import 'app_text.dart';

class AppDialogWithTwoButton extends StatelessWidget {
  const AppDialogWithTwoButton({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.dialogRadius = 12,
    this.insetPadding,
    this.contentPadding,
    this.type = AppDialogType.warning,
    this.titleButton,
    this.onTap,
    this.titleFontWeight,
    this.onTapCancelButton,
    this.firstTextColor,
    this.secondTextColor,
  });
  final Color? firstTextColor;
  final Color? secondTextColor;
  final Widget? child;
  final EdgeInsets? insetPadding;
  final double dialogRadius;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final AppDialogType type;
  final String? titleButton;
  final FontWeight? titleFontWeight;
  final VoidCallback? onTapCancelButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: insetPadding ?? EdgeInsets.only(left: 16.w, right: 16.w),
      elevation: 0,
      backgroundColor: ColorName.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogRadius.sp),
      ),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.all(16),
        child: Column(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title,
              fontSize: UIConst.defaultFontSize * 1.5,
              fontWeight: titleFontWeight ?? FontWeight.bold,
              textColor: ColorName.black,
              padding: EdgeInsets.only(top: 9.h),
            ),

            if (subtitle != null)
              AppText(
                subtitle!,
                fontSize: UIConst.defaultFontSize,
                fontWeight: titleFontWeight,
                textColor: ColorName.black,
                padding: EdgeInsets.only(top: 9.h),
              ),

            child ?? SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    
                    onPressed: () {
                      Navigator.of(context).pop();
                      onTapCancelButton?.call();
                    },
                    //Navigator.of(context, rootNavigator: true).pop(),
                    title: 'CANCEL',
                    height: 40.h,
                    style: AppButtonStyle(
                      textColor: firstTextColor ,
                      radius: UIConst.defaultBorderRadius/6,
                      backgroundColor: ColorName.blueFile,
                      borderColor: ColorName.grayBackground,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: AppButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onTap?.call();
                    },
                    title: titleButton ?? 'OK',
                    height: 40.h,
                    style: AppButtonStyle(
                      textColor: secondTextColor ,
                      radius: UIConst.defaultBorderRadius/6,
                      backgroundColor: ColorName.white,
                      borderColor: ColorName.blueFile,
                      borderWidth: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
