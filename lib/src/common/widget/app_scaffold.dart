import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/colors.gen.dart';
import '../extension/app_x.dart';
import '../extension/optional_x.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.useBackgroundImage = false,
    this.leading,
    this.visibleAppBar = true,
    this.titleAppBar,
    this.needUnFocus = false,
    this.onLeadingPressed,
    this.actions,
    this.bottom,
    this.onPressed,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = false,
    this.canPop = true,
    this.onPopScope,
    this.floatingActionButton,
    this.useBackgroundColor = false,
    this.hasBackButton = false,
    this.toolbarHeight = 56,
    this.leadingWidth = 48,
    this.titleSpacing = 0,
    this.backgroundImage,
    this.centerTitle = true,
    this.leadingPadding,
    this.appBarColor,
    this.leadingColor,
    this.hasAppbarLine = false,
    this.backButtonColor,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final bool useBackgroundImage;
  final Widget? leading;
  final bool visibleAppBar;
  final Widget? titleAppBar;
  final bool needUnFocus;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onPressed;
  final bool? resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final bool canPop;
  final VoidCallback? onPopScope;
  final Widget? floatingActionButton;
  final DecorationImage? backgroundImage;
  final bool useBackgroundColor;
  final bool hasBackButton;
  final double toolbarHeight;
  final double leadingWidth;
  final Color? appBarColor;
  final double titleSpacing;
  final bool centerTitle;
  final EdgeInsetsGeometry? leadingPadding;
  final Color? leadingColor;
  final bool hasAppbarLine;
  final Color? backButtonColor;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        onPopScope?.call();
        unfocusKeyboard();
      },
      canPop: canPop,
      child: GestureDetector(
        onTap: () {
          onPressed?.call();
          if (!needUnFocus) {
            return;
          }
          unfocusKeyboard();
        },
        child: Container(
          decoration: BoxDecoration(
            image: backgroundImage,
            color:
                useBackgroundImage ? null : backgroundColor ?? ColorName.white,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: bottomNavigationBar,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            appBar:
                visibleAppBar
                    ? appBar ??
                        AppBar(
                          centerTitle: centerTitle,
                          toolbarHeight: toolbarHeight.h,
                          elevation: 0,
                          backgroundColor: appBarColor ?? Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          leadingWidth: hasBackButton ? leadingWidth.w : 0,
                          leading: Container(
                            margin: EdgeInsets.only(left: 16.w),
                            decoration:
                                hasBackButton
                                    ? BoxDecoration(
                                      color: backButtonColor ?? ColorName.gray97,
                                      shape: BoxShape.circle,
                                    )
                                    : null,
                            child: Center(
                              child: GestureDetector(
                                onTap:
                                    onLeadingPressed ??
                                    () {
                                      if (hasBackButton) {
                                        Navigator.pop(context);
                                      }
                                    },
                                child:
                                    leading ??
                                    (hasBackButton
                                        ? Padding(
                                          padding:
                                              leadingPadding ?? EdgeInsets.zero,
                                          child: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: leadingColor ?? Colors.white,
                                            size: 24.sp,
                                          ),
                                        )
                                        : null),
                              ),
                            ),
                          ),
                          scrolledUnderElevation: 0,
                          title: titleAppBar,
                          actions: actions,
                          bottom:
                              bottom ??
                              (hasAppbarLine
                                  ? titleAppBar.isNotNull
                                      ? PreferredSize(
                                        preferredSize: Size.fromHeight(14.h),
                                        child: Divider(
                                          height: 0.5,
                                          color: Colors.grey,
                                        ),
                                      )
                                      : bottom
                                  : null),
                          titleSpacing: titleSpacing,
                        )
                    : null,
            body: body,
          ),
        ),
      ),
    );
  }
}
