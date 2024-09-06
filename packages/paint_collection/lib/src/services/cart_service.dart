import 'package:paint_collection/paint_collection.dart';

class CartService {
  final Catalog _catalog;
  final Cart _cart = Cart();

  CartService(this._catalog);

  List<Item> get items => _cart.items;

  void add(int id) {
    _cart.addItem(_catalog.getById(id));
  }

  void remove(int id) {
    _cart.removeItem(_catalog.getById(id));
  }

  void clear() {
    _cart.clear();
  }

  double get totalPrice => _cart.totalPrice.toDouble();
}
