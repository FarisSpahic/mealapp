import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/router/navbar.dart';
import 'package:mealapp/screens/cart_screen.dart';
import 'package:mealapp/screens/compare_items_screen.dart';
import 'package:mealapp/screens/gallery_screen.dart';
import 'package:mealapp/screens/home_screen.dart';
import 'package:mealapp/screens/settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                  child: ScaffoldWithNavBar(
                    location: state.location,
                    child: child,
                  ));
            },
            routes: <RouteBase>[
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: '/',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(
                        key: UniqueKey(),
                        child: const HomeScreen()
                    );
                  },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: '/settings',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(
                      key: UniqueKey(),
                      child: const Settings()
                  );
                },
              ),
              GoRoute(
                  path: '/gallery',
                  parentNavigatorKey: _shellNavigatorKey,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(
                      key: UniqueKey(),
                      child:  GalleryScreen()
                  );
                },
              ),
            ]
        ),
      GoRoute(
      path: '/cart',
      parentNavigatorKey: _shellNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
                  key: UniqueKey(),
                  child: CartScreen()
            );
          }
      ),
        GoRoute(
          path: '/comparison',
        parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state){
            return NoTransitionPage(child: CompareScreen(), key: UniqueKey());
          }
        )
      ]);



