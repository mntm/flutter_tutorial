import 'package:catalog_getx/src/cart/cart.dart';
import 'package:catalog_getx/src/catalog/catalog.dart';
import 'package:catalog_getx/widgets/unified_pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paint_collection/paint_collection.dart';

class CatalogScreen extends StatelessWidget {
  static const String uri = "/";

  const CatalogScreen({super.key});

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

class _ItemListView extends GetView<CatalogController> {
  const _ItemListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UnifiedPullToRefresh(
      onRefresh: () {
        controller.refreshCatalog();
        return Future.delayed(Duration.zero);
      },
      child: GetBuilder<CatalogController>(
        builder: (context) {
          return controller.obx(
              (state) => ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, id) {
                      Item item = state.elementAt(id);
                      return ListTile(
                        leading: SizedBox.square(
                            dimension: 24,
                            child: ColoredBox(color: item.color)),
                        isThreeLine: false,
                        title: Text(item.name),
                        trailing: _AddToCartButtonView(item: item),
                      );
                    },
                  ),
              onLoading: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ));
        },
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
    return GetBuilder<CartController>(
        builder: (controller) => controller.cartItems.contains(item)
            ? _RemoveIconButton(item: item)
            : _AddIconButton(item: item));
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
        Get.find<CartController>().addItemToCart(item);
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
        Get.find<CartController>().removeItemFromCart(item);
      },
      icon: const Icon(Icons.remove),
    );
  }
}

class _CartActionView extends GetView<CartController> {
  const _CartActionView();

  @override
  Widget build(BuildContext context) {
    var iconButton = IconButton(
      onPressed: () {},
      icon: const Icon(Icons.shopping_cart),
    );

    return GetBuilder<CartController>(
      builder: (controller) => controller.cartItems.isEmpty
          ? iconButton
          : Badge.count(
              count: controller.cartItems.length,
              child: iconButton,
            ),
    );
  }
}
