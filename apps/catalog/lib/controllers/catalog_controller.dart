import 'package:paint_collection/paint_collection.dart';

class CatalogController {
  final CatalogService _service;

  CatalogController(this._service);

  CatalogService get catalogService => _service;
}
