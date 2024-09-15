import 'package:catalog_getx/src/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paint_collection/paint_collection.dart';

class CartScreen extends StatelessWidget {
  static const String uri = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !GetPlatform.isWeb,
        title: const Text("Cart"),
        centerTitle: true,
        titleTextStyle: textTheme.headlineLarge,
      ),
      backgroundColor: Colors.yellow,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CartItemListView(),
          Divider(
            height: 4,
            color: Colors.black,
          ),
          _CartTotalView(),
        ],
      ),
    );
  }
}

class _CartTotalView extends StatelessWidget {
  const _CartTotalView();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _PriceTextView(),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  "BUY",
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.find<CartController>().clearCart();
                },
                child: const Text("Clear"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceTextView extends StatelessWidget {
  const _PriceTextView();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Text(
            "\$${controller.totalPrice.toStringAsFixed(2)}",
            style:
                textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
          );
        });
  }
}

class _CartItemListView extends StatelessWidget {
  const _CartItemListView();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Expanded(
          child: ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, id) {
              Item item = controller.cartItems.elementAt(id);
              return ListTile(
                isThreeLine: false,
                leading: const Icon(
                  Icons.circle,
                  size: 8,
                ),
                title: Text(item.name),
              );
            },
          ),
        );
      },
    );
  }
}
