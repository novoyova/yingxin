import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yuanrung/features/auth/application/auth_page.dart';
import 'package:yuanrung/features/home/application/home_page.dart';
import 'package:yuanrung/features/splash/application/splash_page.dart';

abstract final class AppRouter {
  static const String className = 'AppRouter';

  static String currentRoute = '/';

  static NavigatorObserver get navigatorObserver => _AppRouteObserver();

  static Route onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');
    final route = uri.path;

    return switch (route) {
      SplashPage.routeName => MaterialPageRoute(
        settings: settings,
        builder: (_) => const SplashPage(),
      ),
      AuthPage.routeName => MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthPage(),
      ),
      HomePage.routeName => MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomePage(),
      ),
      _ => MaterialPageRoute(
        settings: settings,
        builder: (_) => const Placeholder(),
      ),
    };
  }
}

final class _AppRouteObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null && previousRoute.settings.name != null) {
      final previousRouteName = _getRoutePath(previousRoute.settings.name!);
      AppRouter.currentRoute = previousRouteName;
      log(
        'didPop => previousRouteName: $previousRouteName',
        name: AppRouter.className,
      );
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      final routeName = _getRoutePath(route.settings.name!);
      AppRouter.currentRoute = routeName;
      log('didPush => routeName: $routeName', name: AppRouter.className);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute != null && previousRoute.settings.name != null) {
      final previousRouteName = _getRoutePath(previousRoute.settings.name!);
      AppRouter.currentRoute = previousRouteName;
      log(
        'didRemove => previousRouteName: $previousRouteName',
        name: AppRouter.className,
      );
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null && newRoute.settings.name != null) {
      final newRouteName = _getRoutePath(newRoute.settings.name!);
      AppRouter.currentRoute = newRouteName;
      log(
        'didReplace => newRouteName: $newRouteName',
        name: AppRouter.className,
      );
    }
  }

  String _getRoutePath(String path) {
    final uri = Uri.parse(path);
    return uri.path;
  }
}
