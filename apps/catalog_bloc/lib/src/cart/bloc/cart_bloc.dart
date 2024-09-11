import 'dart:async';

import 'package:catalog_bloc/src/data/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_collection/paint_collection.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Repository repository;
  CartBloc(this.repository) : super(const CartEmpty([])) {
    on<CartCleared>(_onCartCleared);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
  }

  FutureOr<void> _onCartCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartEmpty([]));
    repository.clearCart();
  }

  FutureOr<void> _onCartItemAdded(
      CartItemAdded event, Emitter<CartState> emit) {
    repository.addToCart(event.item);
    emit(CartSupplied(repository.cartItems));
  }

  FutureOr<void> _onCartItemRemoved(
      CartItemRemoved event, Emitter<CartState> emit) {
    repository.removeFromCart(event.item);
    if (repository.cartItems.isEmpty) {
      emit(const CartEmpty([]));
    } else {
      emit(CartSupplied(repository.cartItems));
    }
  }
}
