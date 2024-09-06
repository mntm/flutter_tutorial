import 'package:paint_catalog/models/catalog.dart';
import 'package:paint_catalog/models/item.dart';

class CatalogService {
  final Catalog _catalog;

  CatalogService(this._catalog);

  Catalog get catalog => _catalog;

  Item getById(int id) => _catalog.getById(id);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }

  Future<void> removeItem(Item item) async {
    throw UnimplementedError("This feature is still a WIP");
  }
}
