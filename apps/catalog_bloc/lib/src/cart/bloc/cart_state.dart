part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  final List<Item> items;

  const CartState(this.items);
  @override
  List<Object?> get props => [items];
}

class CartEmpty extends CartState {
  const CartEmpty(super.items);
}

class CartSupplied extends CartState {
  const CartSupplied(super.items);
}
