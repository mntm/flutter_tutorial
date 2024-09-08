import 'package:catalog_bloc/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: ScreenRoutes.homeDestination.uri,
      builder: ScreenRoutes.homeDestination.page,

      /// uses subroute to enable animation between screens
      /// and automatically add a back button on the AppBar
      routes: [
        GoRoute(
          path: ScreenRoutes.cartDestination.uri,
          builder: ScreenRoutes.cartDestination.page,
        )
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
