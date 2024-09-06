import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paint_catalog/models/catalog.dart';
import 'package:paint_catalog/screens/cart_screen.dart';
import 'package:paint_catalog/screens/catalog_screen.dart';

void main() {
  runApp(const MainApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: CatalogScreen.uri,
      builder: (context, state) => CatalogScreen(
        catalog: Catalog(),
      ),

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
