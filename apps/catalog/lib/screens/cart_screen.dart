import 'package:flutter/material.dart';
import 'package:paint_catalog/models/item.dart';

class CartScreen extends StatelessWidget {
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
          const _CartTotalView(230),
        ],
      ),
    );
  }
}

class _CartTotalView extends StatelessWidget {
  const _CartTotalView(
    this.totalPrice, {
    super.key,
  });

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "\$$totalPrice",
            style:
                textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
          ),
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
        ],
      ),
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
    return Expanded(
      child: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, id) {
          return ListTile(
            trailing: const Icon(
              Icons.circle,
              size: 8,
            ),
            title: Text(cart[id].name),
          );
        },
      ),
    );
  }
}
