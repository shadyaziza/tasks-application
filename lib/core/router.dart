// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/home_page.dart';
import 'package:task_list_app/pages/tasks/_view/task_details_page.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';

import '../pages/projects/_view/projects_page.dart';

/// TODO: 3. Implement a navigation (using go_router package) that supports changing urls and back button in the browser.

final routerProvider = Provider<GoRouter>((ref) {
  final router = AsyncRouterNotifier(ref);
  return GoRouter(
    initialLocation: AppRouter.kRoutePathTaskDetails,
    navigatorKey: AppRouter.rootNavigationKey,
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirect,
    routes: router._routes,
  );
});

/// Passing [_ref] here is important for accessing app state and change redirection logic
/// based on other providers state
///
class AsyncRouterNotifier extends ChangeNotifier {
  final Ref _ref;

  AsyncRouterNotifier(this._ref);
  List<RouteBase> get _routes => AppRouter.routes;

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    /// for the intial navigation because once we start the app
    /// we view tasks which in turn view the first task
    ///
    if (state.location.contains('taskId') || state.location == '/tasks') {
      return '/tasks/1';
    }
    return null;
  }
}

class AppRouter {
  static const kRoutePathTasks = '/tasks';
  static const kRouteNameTasks = 'TaskNamedRoute';

  /// TODO: 4. Add a side menu or navigation bar with 3 pages (Tasks, Projects and Teams).
  ///
  /// TODO: 5. Use _getTasks_ method from _network_service.dart_ file to get data for the _Tasks_ page.
  ///
  static const kRoutePathTaskDetails = '/tasks/:taskId';
  static const kRouteNameTaskDetails = 'TaskDetailsNamedRoute';

  static const kRoutePathProjects = '/projects';
  static const kRouteNameProjects = 'ProjectsNamedRoute';
  static const kRoutePathTeams = '/teams';
  static const kRouteNameTeams = 'TeamsNamedRoute';
  static final rootNavigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'RootNavigationKey');
  static final mainAppShellKey =
      GlobalKey<NavigatorState>(debugLabel: 'MainAppShellKey');
  static final tasksShellKey =
      GlobalKey<NavigatorState>(debugLabel: 'TasksShellKey');
  static List<RouteBase> routes = [
    ShellRoute(
      navigatorKey: tasksShellKey,
      routes: [
        ShellRoute(
            builder: (context, state, child) {
              return TasksPage(
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: kRoutePathTaskDetails,
                name: kRouteNameTaskDetails,
                builder: (context, state) {
                  final int taskId =
                      int.tryParse(state.pathParameters['taskId'] ?? '1') ?? 1;

                  return TasksDetailsPage(
                    taskId: taskId,
                  );
                },
              ),
            ]),
        GoRoute(
          path: kRoutePathProjects,
          name: kRouteNameProjects,
          builder: (context, state) {
            return const ProjectsPage();
          },
        ),
        GoRoute(
          path: kRoutePathTeams,
          name: kRouteNameTeams,
          builder: (context, state) {
            return const TeamsPage();
          },
        )
      ],
      builder: (context, state, child) {
        return HomePage(
          child: child,
        );
      },
    ),
  ];
}
