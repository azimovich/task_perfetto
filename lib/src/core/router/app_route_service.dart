import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_perfetto/src/future/splash/splash_page.dart';

import '../../future/auth/view/pages/register_page.dart';
import '../../future/auth/view/pages/verify_code_page.dart';
import '../../future/choose_language/view/pages/choose_language_page.dart';
import '../../future/home/home_page.dart';
import 'app_route_names.dart';

GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();

Page<dynamic> customEachTransitionAnimation(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<Object>(
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      var begin = const Offset(1.0, 0.0); // From right
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    child: child,
  );
}

@immutable
class AppRouteService {
  const AppRouteService._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: parentNavigatorKey,
    initialLocation: AppRouteNames.splashPage,
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteNames.splashPage,
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: AppRouteNames.chooseLanguagePage,
        builder: (context, state) => ChooseLanguagePage(),
      ),
      GoRoute(
        path: AppRouteNames.registerPage,
        pageBuilder: (context, state) => customEachTransitionAnimation(context, state, RegisterPage()),
        routes: <RouteBase>[
          GoRoute(
            path: AppRouteNames.verifyCodePage,
            pageBuilder: (context, state) => customEachTransitionAnimation(
              context,
              state,
              VerifyCodePage(
                phoneNumber: state.extra as String,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRouteNames.homePage,
        builder: (context, state) => HomePage(),
      ),
    ],
  );
}
