import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';
import '../../../../core/themes/light_theme.dart';

class GradientBG extends StatelessWidget {
  const GradientBG({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.topCenter,
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.gradient1, MyColors.gradient2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Image.asset(
          Constants.logo,
          height: height * 0.32,
          width: width * 0.5,
        ),
      ),
    );
  }
}
