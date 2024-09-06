import 'package:flutter/material.dart';
import 'package:paint_collection/paint_collection.dart';

class CartController extends ChangeNotifier {
  final CartService _cartService;

  CartController(this._cartService);

  List<Item> get items => _cartService.items;

  void add(int id) {
    _cartService.add(id);
    notifyListeners();
  }

  void remove(int id) {
    _cartService.remove(id);
    notifyListeners();
  }

  void clear() {
    _cartService.clear();
    notifyListeners();
  }

  double get totalPrice => _cartService.totalPrice.toDouble();
}
