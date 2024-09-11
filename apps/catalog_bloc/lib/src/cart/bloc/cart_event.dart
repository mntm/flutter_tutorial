// ignore_for_file: recursive_getters

part of 'cart_bloc.dart';

sealed class CartEvent {
  final Item? item;

  CartEvent(this.item);
}

class CartItemAdded extends CartEvent {
  CartItemAdded(Item super.item);
  @override
  Item get item => item;
}

class CartItemRemoved extends CartEvent {
  CartItemRemoved(Item super.item);
  @override
  Item get item => item;
}

class CartCleared extends CartEvent {
  CartCleared() : super(null);
}
