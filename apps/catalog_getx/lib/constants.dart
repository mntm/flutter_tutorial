import 'package:catalog_getx/src/cart/ui/cart_screen.dart';
import 'package:catalog_getx/src/catalog/ui/catalog_screen.dart';
import 'package:flutter/material.dart';

class ScreenDestination {
  final String uri;
  final Widget Function(BuildContext, Object?) page;

  ScreenDestination(this.uri, this.page);
}

class ScreenRoutes {
  static ScreenDestination homeDestination = ScreenDestination(
    CatalogScreen.uri,
    (_, __) => const CatalogScreen(),
  );
  static ScreenDestination cartDestination = ScreenDestination(
    CartScreen.uri,
    (_, __) => CartScreen(),
  );
}
