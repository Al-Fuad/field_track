import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_name.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/bottom_nav/presentation/pages/bottom_nav_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/locations/presentation/pages/locations_page.dart';
import '../../features/locations/domain/models/location_model.dart';
import '../../features/new_location/presentation/pages/new_location_page.dart';
import '../../features/edit_location/presentation/pages/edit_location_page.dart';
import '../../features/sync/presentation/pages/sync_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorTasks = GlobalKey<NavigatorState>(debugLabel: 'tasksTab');
final GlobalKey<NavigatorState> _shellNavigatorLocations = GlobalKey<NavigatorState>(debugLabel: 'locationsTab');
final GlobalKey<NavigatorState> _shellNavigatorSync = GlobalKey<NavigatorState>(debugLabel: 'syncTab');
final GlobalKey<NavigatorState> _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'profileTab');
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: RouteName.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
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
              path: '/tasks',
              name: RouteName.tasks,
              builder: (context, state) => const TasksPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocations,
          routes: [
            GoRoute(
              path: '/locations',
              name: RouteName.locations,
              builder: (context, state) => const LocationsPage(),
              routes: [
                GoRoute(
                  path: 'new',
                  name: RouteName.newLocation,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const NewLocationPage(),
                ),
                GoRoute(
                  path: 'edit',
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
              path: '/sync',
              name: RouteName.sync,
              builder: (context, state) => const SyncPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfile,
          routes: [
            GoRoute(
              path: '/profile',
              name: RouteName.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
