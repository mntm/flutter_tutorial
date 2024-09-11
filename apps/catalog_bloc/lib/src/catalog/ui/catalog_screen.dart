import 'package:catalog_bloc/constants.dart';
import 'package:catalog_bloc/src/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state is CatalogInitial) {
          context.read<CatalogBloc>().add(CatalogInitiated());
          return const SizedBox.shrink();
        }
        List<Item> catalog = state.items;
        return CustomScrollView(
          slivers: [
            if (state is CatalogLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            if (state is CatalogReady)
              SliverList.builder(
                itemCount: catalog.length,
                itemBuilder: (context, id) {
                  Item item = catalog.elementAt(id);
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
      },
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
    return _DeselectedIconButton(item: item);
  }
}

class _DeselectedIconButton extends StatelessWidget {
  const _DeselectedIconButton({
    super.key,
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

class _SelectedIconButton extends StatelessWidget {
  const _SelectedIconButton({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.remove),
    );
  }
}

class _CartActionView extends StatelessWidget {
  const _CartActionView();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.go(ScreenRoutes.cartDestination.uri);
      },
      icon: const Icon(Icons.shopping_cart),
    );
  }
}
