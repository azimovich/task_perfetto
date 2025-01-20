import "package:flutter/material.dart";

import "../router/app_route_service.dart";

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouteService.router,
    );
  }
}
