import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../generated/assets.gen.dart';
import '../../common/utils/getit_utils.dart';
import 'app_router.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  SplashPage({super.key}) {
    fetchAll();
  }

  fetchAll() async {
    await Future.delayed(Duration(seconds: 3));
    return getIt<AppRouter>().replaceAll([FoodRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.imgSplashScreen.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Lottie.asset(
          Assets.lottie.loading,
          repeat: true,
          fit: BoxFit.cover,
          width: 360.w,
        ),
      ),
    );
  }
}
