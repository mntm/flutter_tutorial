import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paint_catalog/models/catalog.dart';
import 'package:paint_catalog/models/item.dart';
import 'package:paint_catalog/screens/cart_screen.dart';

class CatalogScreen extends StatefulWidget {
  static const String uri = "/";

  const CatalogScreen({super.key, required this.catalog});
  final Catalog catalog;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text("Catalog", style: textTheme.headlineLarge)),
        actions: [
          Badge.count(
            count: 0,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    /// Use `goNamed` instead of `go` to simplify the syntax
                    context.goNamed(CartScreen.uri);
                  },
                  icon: const Icon(Icons.shopping_cart)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, id) {
            Item item = widget.catalog.getById(id);
            return ListTile(
              leading: SizedBox.square(
                  dimension: 24, child: ColoredBox(color: item.color)),
              isThreeLine: false,
              title: Text(item.name),
              trailing: _AddToCartButtonView(item: item),
            );
          },
        ),
      ),
    );
  }
}
class _AddToCartButtonView extends StatelessWidget {
  const _AddToCartButtonView({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        return cart.items.contains(item)
            ? IconButton(
                onPressed: () {
                  context.read<CartController>().remove(item.id);
                },
                icon: const Icon(
                  Icons.remove,
                  color: Colors.red,
                ),
              )
            : child!;
      },
      child: IconButton(
        onPressed: () {
          context.read<CartController>().add(item.id);
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
