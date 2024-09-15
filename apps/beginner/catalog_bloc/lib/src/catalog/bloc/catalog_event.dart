part of "catalog_bloc.dart";

sealed class CatalogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CatalogItemReceived extends CatalogEvent {
  final Item item;
  CatalogItemReceived(this.item);
  @override
  List<Object?> get props {
    super.props.add(item);
    return super.props;
  }
}

class CatalogItemCompleted extends CatalogEvent {}

class CatalogRefreshRequested extends CatalogEvent {
  CatalogRefreshRequested();
}

class CatalogInitiated extends CatalogEvent {
  CatalogInitiated();
}
