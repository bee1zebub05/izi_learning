import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/src/common/constants/ui_constant.dart';

import '../../../../generated/colors.gen.dart';
import 'app_button.dart';
import 'app_text.dart';

enum AppDialogType { warning, success }

class AppDialog extends StatelessWidget {
  const AppDialog({
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
    this.textColor,
  });
  final Widget? child;
  final Color? textColor;
  final EdgeInsets? insetPadding;
  final double dialogRadius;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final AppDialogType type;
  final String? titleButton;
  final FontWeight? titleFontWeight;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          insetPadding ??
          EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            // bottom: context.mediaQuery.size.height / 2 - 350.h
          ),
      elevation: 0,
      backgroundColor: ColorName.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogRadius.sp),
      ),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: UIConst.defaultPadding),
            AppText(
              title,
              fontSize: UIConst.defaultFontSize * 1.5,
              fontWeight: titleFontWeight ?? FontWeight.w600,
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
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(
                UIConst.defaultPadding,
                0,
                UIConst.defaultPadding,
                UIConst.defaultPadding,
              ),
              child: AppButton(
                onPressed: () {
                  if (onTap != null) {
                    onTap!.call();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                title: titleButton ?? 'OK',
                height: 56,
                style: AppButtonStyle(
                  textColor: textColor,
                  radius: UIConst.defaultBorderRadius / 6,
                  backgroundColor: ColorName.blueFile,
                  borderColor: ColorName.grayBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
