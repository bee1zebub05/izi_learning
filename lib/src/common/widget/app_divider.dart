import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/generated/colors.gen.dart';
import 'package:learning/src/common/constants/ui_constant.dart';

Widget customDivider({
  double thick = 0.5,
  Color color = ColorName.grayBackground,
  Axis axis = Axis.horizontal,
}) {
  Axis axis0 = axis;
  if (axis0 == Axis.horizontal) {
    return Divider(
      color: ColorName.grayBackground,
      thickness: thick.w,
      indent: UIConst.defaultPadding / 2,
      endIndent: UIConst.defaultPadding / 2,
    );
  } else {
    return VerticalDivider(
      color: ColorName.grayBackground,
      thickness: thick.w,
      indent: UIConst.defaultPadding / 2,
      endIndent: UIConst.defaultPadding / 2,
    );
  }
}
