import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:learning/generated/colors.gen.dart';
import 'package:learning/src/common/widget/app_scaffold.dart';

@RoutePage()
class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Container(color: ColorName.blueFile,));
  }
}