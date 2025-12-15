import 'package:flutter/material.dart';
import 'package:learning/generated/colors.gen.dart';
import 'package:learning/src/common/widget/app_scaffold.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(color: ColorName.greenFile,)
    );
  }
}