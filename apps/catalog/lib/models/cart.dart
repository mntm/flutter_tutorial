import 'dart:collection';

import 'package:paint_catalog/models/item.dart';

class Cart {
  // this gets modified internally
  final List<Item> _items = [];
  // this is a view, a proxy, of _items. It can only be read not written
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.fold<int>(0, (sum, item) => sum + item.price);

  void addItem(Item item) {
    _items.add(item);
  }

  void removeItem(Item item) {
    _items.remove(item);
  }

  void clear() {
    _items.clear();
  }
}
