import 'package:catalog_getx/constants.dart';
import 'package:catalog_getx/src/cart/cart.dart';
import 'package:catalog_getx/src/catalog/catalog.dart';
import 'package:catalog_getx/widgets/auto_hide_badge_count.dart';
import 'package:catalog_getx/widgets/browser_compatible_app_bar.dart';
import 'package:catalog_getx/widgets/custom_circular_progress_indicator.dart';
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
      appBar: BrowserCompatibleAppBar(
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
        init: CatalogController(),
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
                child: CustomCircularProgressIndicator(),
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
        init: CartController(),
        builder: (controller) => controller.cartItems.contains(item)
            ? _RemoveIconButton(item: item)
            : _AddIconButton(item: item));
  }
}

class _AddIconButton extends GetView<CartController> {
  const _AddIconButton({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        controller.addItemToCart(item);
      },
      icon: const Icon(Icons.add),
    );
  }
}

class _RemoveIconButton extends GetView<CartController> {
  const _RemoveIconButton({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        controller.removeItemFromCart(item);
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
      onPressed: () {
        Get.toNamed(ScreenRoutes.cartDestination.uri);
      },
      icon: const Icon(Icons.shopping_cart),
    );

    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) => AutoHideBadgeCount(
        count: controller.cartItems.length,
        child: iconButton,
      ),
    );
  }
}
