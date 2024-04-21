import 'package:coach_finder/features/home/ui/home_screen.dart';
import 'package:coach_finder/features/profile/ui/profile_screen.dart';
import 'package:coach_finder/features/root/root_screen.dart';
import 'package:coach_finder/features/workout_plans/create_workout_plan/create_workout_plan.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => RootScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomeScreen(
                key: state.pageKey,
              ),
              routes: [
                GoRoute(
                  path: 'create_workout_plan',
                  name: 'create_workout_plan',
                  builder: (context, state) => CreateWorkoutPlanScreen(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => ProfileScreen(
                key: state.pageKey,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
