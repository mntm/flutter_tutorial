import 'package:catalog_bloc/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paint_collection/paint_collection.dart';

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
    Catalog catalog = Catalog();

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
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.add),
    );
  }
}

class _CartActionView extends StatelessWidget {
  const _CartActionView();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        /// Use `goNamed` instead of `go` to simplify the syntax
        context.goNamed(CartScreen.uri);
      },
      icon: const Icon(Icons.shopping_cart),
    );
  }
}
