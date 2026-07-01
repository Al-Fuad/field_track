import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_name.dart';
import 'route_path.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/bottom_nav/presentation/pages/bottom_nav_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/locations/presentation/pages/locations_page.dart';
import '../../features/locations/domain/entities/location.dart';
import '../../features/locations/presentation/pages/new_location_page.dart';
import '../../features/locations/presentation/pages/edit_location_page.dart';
import '../../features/sync/presentation/pages/sync_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorTasks =
    GlobalKey<NavigatorState>(debugLabel: 'tasksTab');
final GlobalKey<NavigatorState> _shellNavigatorLocations =
    GlobalKey<NavigatorState>(debugLabel: 'locationsTab');
final GlobalKey<NavigatorState> _shellNavigatorSync = GlobalKey<NavigatorState>(
  debugLabel: 'syncTab',
);
final GlobalKey<NavigatorState> _shellNavigatorProfile =
    GlobalKey<NavigatorState>(debugLabel: 'profileTab');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.login,
      name: RouteName.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RoutePath.register,
      name: RouteName.register,
      builder: (context, state) => const RegisterPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorTasks,
          routes: [
            GoRoute(
              path: RoutePath.tasks,
              name: RouteName.tasks,
              builder: (context, state) => const TasksPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocations,
          routes: [
            GoRoute(
              path: RoutePath.locations,
              name: RouteName.locations,
              builder: (context, state) => const LocationsPage(),
              routes: [
                GoRoute(
                  path: RoutePath.newLocation,
                  name: RouteName.newLocation,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const NewLocationPage(),
                ),
                GoRoute(
                  path: RoutePath.editLocation,
                  name: RouteName.editLocation,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final location = state.extra as Location;
                    return EditLocationPage(location: location);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSync,
          routes: [
            GoRoute(
              path: RoutePath.sync,
              name: RouteName.sync,
              builder: (context, state) => const SyncPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfile,
          routes: [
            GoRoute(
              path: RoutePath.profile,
              name: RouteName.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
