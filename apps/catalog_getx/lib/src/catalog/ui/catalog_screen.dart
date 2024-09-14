import 'package:catalog_getx/constants.dart';
import 'package:catalog_getx/src/app.dart';
import 'package:catalog_getx/widgets/unified_pull_to_refresh.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
      body: const SafeArea(
        child: _ItemListView(),
      ),
    );
  }
}

class _ItemListView extends StatelessWidget {
  const _ItemListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UnifiedPullToRefresh(
        onRefresh: () {
          return Future.delayed(Duration.zero);
        },
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: repository.catalogItems.length,
              itemBuilder: (context, id) {
                Item item = repository.catalogItems.elementAt(id);
                return ListTile(
                  leading: SizedBox.square(
                      dimension: 24, child: ColoredBox(color: item.color)),
                  isThreeLine: false,
                  title: Text(item.name),
                  trailing: _AddToCartButtonView(item: item),
                );
              },
            )
          ],
        ));
  }
}

class _AddToCartButtonView extends StatelessWidget {
  const _AddToCartButtonView({
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return repository.cartItems.contains(item)
        ? _RemoveIconButton(item: item)
        : _AddIconButton(item: item);
  }
}

class _AddIconButton extends StatelessWidget {
  const _AddIconButton({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        repository.addToCart(item);
      },
      icon: const Icon(Icons.add),
    );
  }
}

class _RemoveIconButton extends StatelessWidget {
  const _RemoveIconButton({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        return repository.removeFromCart(item);
      },
      icon: const Icon(Icons.remove),
    );
  }
}

class _CartActionView extends StatelessWidget {
  const _CartActionView();

  @override
  Widget build(BuildContext context) {
    var iconButton = IconButton(
      onPressed: () {
        context.goNamed(ScreenRoutes.cartDestination.uri);
      },
      icon: const Icon(Icons.shopping_cart),
    );
    return repository.cartItems.isEmpty
        ? iconButton
        : Badge.count(
            count: repository.cartItems.length,
            child: iconButton,
          );
  }
}
