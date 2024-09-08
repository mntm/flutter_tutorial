import 'package:flutter/material.dart';
import 'package:paint_collection/paint_collection.dart';

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
  const _CartTotalView();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _PriceTextView(0.0),
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
                onPressed: () {},
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
  const _PriceTextView(this._value);

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
    required this.cart,
  });

  final List<Item> cart;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, id) {
          Item item = cart[id];
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
  }
}
