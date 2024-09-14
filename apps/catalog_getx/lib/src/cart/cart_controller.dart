import 'package:catalog_getx/src/data/repository.dart';
import 'package:get/get.dart';
import 'package:paint_collection/paint_collection.dart';

class CartController extends GetxController {
  late final Repository _repo;

  @override
  void onInit() {
    super.onInit();
    _repo = Get.find();
  }

  void addItemToCart(Item item) {
    _repo.addToCart(item);
    update();
  }

  void removeItemFromCart(Item item) {
    _repo.removeFromCart(item);
    update();
  }

  void clearCart() {
    // _repo.clearCart();
    update();
  }

  void refreshCart() {}

  get totalPrice => _repo.totalCartPrice.obs;
  RxList<Item> get cartItems => List.of(_repo.cartItems).obs;
}
