part of "catalog_bloc.dart";

sealed class CatalogEvent {}

class CatalogItemReceived extends CatalogEvent {
  final Item item;
  CatalogItemReceived(this.item);
}

class CatalogItemCompleted extends CatalogEvent {}

class CatalogUpdated extends CatalogEvent {
  CatalogUpdated();
}

class CatalogInitiated extends CatalogEvent {
  CatalogInitiated();
}
