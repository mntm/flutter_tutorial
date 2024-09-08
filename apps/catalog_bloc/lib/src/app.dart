import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'cart/cart_screen.dart';
import 'catalog/catalog_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: CatalogScreen.uri,
      builder: (context, state) => const CatalogScreen(),

      /// uses subroute to enable animation between screens
      /// and automatically add a back button on the AppBar
      routes: [
        GoRoute(
          path: CartScreen.uri,
          builder: (_, __) => CartScreen(),
          name: CartScreen.uri,
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
