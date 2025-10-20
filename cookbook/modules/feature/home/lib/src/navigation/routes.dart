import 'package:core_common/navigation/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/home/inner_pages/explore_page.dart';
import 'package:home/src/ui/home/inner_pages/home_page.dart';
import 'package:home/src/ui/home/inner_pages/profile_page.dart';
import 'package:home/src/ui/home/inner_pages/settings_page.dart';
import 'package:home/src/ui/home/skeleton_home_page.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class HomeRoutes {
  HomeRoutes._();

  static const base = '/app';
  static const explorer = '$base/explorer';
  static const home = '$base/home';
  static const profile = '$base/profile';
  static const settings = '$base/settings';
}

extension _Navigation on String {
  String get removeBase => replaceFirst('${HomeRoutes.base}/', '');
}

final homeRoutes = GoRoute(
  path: HomeRoutes.base,
  builder: (context, state) => Container(),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return SkeletonHomePage(
          index: navigationShell.currentIndex,
          child: navigationShell,
          onTap: (index) => navigationShell.goBranch(index),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            createRoute(
              withParentRootKey: false,
              path: HomeRoutes.home.removeBase,
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            createRoute(
              withParentRootKey: false,
              path: HomeRoutes.explorer.removeBase,
              builder: (context, state) => ExplorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            createRoute(
              withParentRootKey: false,
              path: HomeRoutes.profile.removeBase,
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            createRoute(
              withParentRootKey: false,
              path: HomeRoutes.settings.removeBase,
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
