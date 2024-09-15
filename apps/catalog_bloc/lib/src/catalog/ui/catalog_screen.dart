import 'package:catalog_bloc/constants.dart';
import 'package:catalog_bloc/src/cart/bloc/cart_cubit.dart';
import 'package:catalog_bloc/src/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mntm_widgets/mntm_widgets.dart';
import 'package:paint_collection/paint_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        CatalogBloc catalogBloc =
            BlocProvider.of<CatalogBloc>(context, listen: false);
        catalogBloc.add(CatalogRefreshRequested());
        return catalogBloc.stream.firstWhere((state) {
          return state is CatalogReady;
        });
      },
      child: BlocBuilder<CatalogBloc, CatalogState>(builder: (context, state) {
        return CustomScrollView(
          slivers: [
            if (state is CatalogInitial)
              const SliverFillRemaining(
                child: Center(
                  child: Text("Pull to refresh"),
                ),
              ),
            if (state is! CatalogInitial)
              SliverList.builder(
                itemCount: state.items.length,
                itemBuilder: (context, id) {
                  Item item = state.items.elementAt(id);
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
        );
      }),
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
    return BlocBuilder<CartCubit, List<Item>>(
      builder: (context, state) {
        return state.contains(item)
            ? _RemoveIconButton(item: item)
            : _AddIconButton(item: item);
      },
    );
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
        context.read<CartCubit>().addItemToCart(item);
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
        context.read<CartCubit>().removeItemFromCart(item);
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
    return BlocBuilder<CartCubit, List<Item>>(builder: (context, state) {
      return state.isEmpty
          ? iconButton
          : Badge.count(
              count: state.length,
              child: iconButton,
            );
    });
  }
}
