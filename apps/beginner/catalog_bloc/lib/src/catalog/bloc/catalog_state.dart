part of "catalog_bloc.dart";

sealed class CatalogState extends Equatable {
  final List<Item> items;
  const CatalogState(this.items);

  @override
  List<Object> get props => [items];
}

class CatalogInitial extends CatalogState {
  CatalogInitial() : super([]);
}

class CatalogLoading extends CatalogState {
  const CatalogLoading(super.items);
}

class CatalogReady extends CatalogState {
  const CatalogReady(super.items);
}
