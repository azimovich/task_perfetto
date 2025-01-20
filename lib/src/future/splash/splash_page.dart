import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/router/app_route_names.dart';
import '../../core/router/app_route_service.dart';
import '../../core/setting/setup.dart';
import '../../core/style/app_colors.dart';
import '../../core/tools/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (language == null) {
        AppRouteService.router.go(AppRouteNames.chooseLanguagePage);
      } else if (accessToken == null) {
        AppRouteService.router.go(AppRouteNames.registerPage);
      } else {
        AppRouteService.router.go("/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SvgPicture.asset(
          Assets.appIconYellowSvg,
          placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
