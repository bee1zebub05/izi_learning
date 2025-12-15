import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/generated/assets.gen.dart';
import 'package:learning/generated/colors.gen.dart';
import 'package:learning/src/common/widget/app_scaffold.dart';
import 'package:learning/src/common/widget/app_text.dart';
import 'package:learning/src/module/foodpage/components/category_item.dart';
import 'package:learning/src/module/foodpage/components/food_banner.dart';
import 'package:learning/src/module/foodpage/components/search_bar.dart';
import 'package:learning/src/module/foodpage/components/tabbar_item.dart';
import 'package:learning/src/module/foodpage/model/category.dart';

Category cate = Category(
  id: "68d23f247735b3001cb8ed76",
  position: 2,
  isDelete: false,
  thumbnail:
      "https://s3-hn-2.cloud.cmctelecom.vn/p105komi/upload/image/1760684635332_4496247c41316f1066ffeaf08_387eeb906a85a593.jpeg",
  name: "Ăn chay sống khỏe",
  createdAt: "2025-10-17T06:56:42.634Z",
  updatedAt: "2025-11-21T07:38:35.546Z",
  slug: "mon-chay",
);

@RoutePage()
class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      centerTitle: false,
      hasBackButton: true,
      actions: [
        TabbarItem(icon: Assets.icons.icShoppingCart1),
        TabbarItem(icon: Assets.icons.icTransactionHistory1),
      ],
      appBarColor: ColorName.white,
      titleAppBar: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            "Giao tới",
            textColor: ColorName.grayText,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Assets.icons.iconLocationMarker.svg(height: 16.sp),
              const SizedBox(width: 4),
              AppText("103 Hoài Thanh", fontWeight: FontWeight.bold),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios_rounded, size: 12),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          spacing: 8.h,
          children: [
            //Search, banners and categories container
            Container(
              color: ColorName.white,
              child: Column(
                children: [
                  //Search
                  FoodSearchBar(),

                  //Banner
                  Padding(
                    padding: EdgeInsets.only(bottom: 18.h),
                    child: SizedBox(
                      height: 132.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (ctx, idx) {
                          //TODO implement state by call API
                          return FoodBanner();
                        },
                      ),
                    ),
                  ),

                  //Categories
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w,0,20.w,18.h),
                    child: SizedBox(
                      height: 218.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, //
                            ),
                        itemBuilder: (ctx, idx) {
                          //TODO implement state by call API
                          return CategoryItem(category: cate);
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    //TODO implement scroll controller
                    child: AppText("Scroll Controller will be here"),
                  )
                ],
              ),
            ),

            Container(color: ColorName.white, height: 100.h,)
          ],
        ),
      ),
    );
  }
}
