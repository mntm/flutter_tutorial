import 'package:flutter/material.dart';
import 'package:paint_catalog/controllers/cart_controller.dart';
import 'package:paint_catalog/models/item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String uri = "cart";

  CartScreen({super.key});
  final List<Item> cart = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        titleTextStyle: textTheme.headlineLarge,
      ),
      backgroundColor: Colors.yellow,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CartItemListView(cart: cart),
          const Divider(
            height: 4,
            color: Colors.black,
          ),
          const _CartTotalView(),
        ],
      ),
    );
  }
}

class _CartTotalView extends StatelessWidget {
  const _CartTotalView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CartController>(
            builder: (context, cart, child) {
              return _PriceTextView(cart.totalPrice);
            },
          ),
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
                  Provider.of<CartController>(context, listen: false).clear();
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
  const _PriceTextView(
    this._value, {
    super.key,
  });

  final double _value;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      "\$${_value.toStringAsFixed(2)}",
      style: textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _CartItemListView extends StatelessWidget {
  const _CartItemListView({
    super.key,
    required this.cart,
  });

  final List<Item> cart;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, id) {
              Item item = cart.items[id];
              return ListTile(
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
