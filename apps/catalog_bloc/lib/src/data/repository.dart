import 'dart:collection';

import 'package:paint_collection/paint_collection.dart';

class Repository {
  late final CatalogService _catalog;
  late final CartService _cart;

  Repository() {
    Catalog catalog = Catalog();
    _catalog = CatalogService(catalog);
    _cart = CartService(catalog);
  }

  // Cart operations
  void addToCart(Item item) {
    _cart.add(item.id);
  }

  void removeFromCart(Item item) {
    _cart.remove(item.id);
  }

  void clearCart() {
    _cart.clear();
  }

  UnmodifiableListView<Item> get cartItems => UnmodifiableListView(_cart.items);
  double get totalCartPrice => _cart.totalPrice;

  // Catalog Operations

  final List<Item> _catalogItems = [];
  UnmodifiableListView<Item> get catalogItems =>
      UnmodifiableListView(_catalogItems);

  void addToCatalog(Item item) {
    _catalogItems.add(item);
  }

  void clearCatalog() {
    _catalogItems.clear();
  }

  Stream<Item> loadCatalog() async* {
    for (var i = 0; i < 100; i++) {
      yield _catalog.getById(i);
      await Future.delayed(const Duration(milliseconds: 20));
    }
  }
}
