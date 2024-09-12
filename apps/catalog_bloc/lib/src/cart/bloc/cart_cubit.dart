import 'package:catalog_bloc/src/data/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_collection/paint_collection.dart';

class CartCubit extends Cubit<List<Item>> {
  final Repository repo;
  CartCubit(this.repo) : super(repo.cartItems);

  void addItemToCart(Item item) {
    repo.addToCart(item);
    emit(List.of(repo.cartItems));
  }

  void removeItemFromCart(Item item) {
    repo.removeFromCart(item);
    emit(List.of(repo.cartItems));
  }

  void clearCart() {
    repo.clearCart();
    emit(List.of(repo.cartItems));
  }
}
