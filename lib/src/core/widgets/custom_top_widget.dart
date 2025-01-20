import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../tools/assets.dart';

class CustomTopWidget extends StatelessWidget {
  const CustomTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 110, right: 110, top: 34, bottom: 48),
      child: SvgPicture.asset(Assets.appIconSvg),
    );
  }
}