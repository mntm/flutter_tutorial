import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paint_catalog/controllers/cart_controller.dart';
import 'package:paint_catalog/controllers/catalog_controller.dart';
import 'package:paint_catalog/models/catalog.dart';
import 'package:paint_catalog/models/item.dart';
import 'package:paint_catalog/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatefulWidget {
  static const String uri = "/";

  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Catalog catalog = context.read<CatalogController>().catalogService.catalog;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("Catalog"),
        titleTextStyle: textTheme.headlineLarge,
        centerTitle: true,
        actions: const [
          _CartActionView(),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, id) {
            Item item = catalog.getById(id);
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

class _CartActionView extends StatelessWidget {
  const _CartActionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          return child ?? const Icon(Icons.shopping_cart_outlined);
        }
        return Badge.count(
          count: cart.items.length,
          child: child,
        );
      },
      child: IconButton(
        onPressed: () {
          /// Use `goNamed` instead of `go` to simplify the syntax
          context.goNamed(CartScreen.uri);
        },
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
