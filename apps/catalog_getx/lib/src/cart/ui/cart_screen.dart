import 'package:catalog_getx/src/app.dart';
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
  const _PriceTextView();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      "\$0.0",
      style: textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _CartItemListView extends StatelessWidget {
  const _CartItemListView();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: repository.cartItems.length,
        itemBuilder: (context, id) {
          Item item = repository.cartItems.elementAt(id);
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
  }
}
