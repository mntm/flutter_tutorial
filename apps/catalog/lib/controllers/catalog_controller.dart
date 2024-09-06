import 'package:paint_catalog/services/catalog_service.dart';

class CatalogController {
  final CatalogService _service;

  CatalogController(this._service);

  CatalogService get catalogService => _service;
}
