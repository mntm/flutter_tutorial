import 'dart:async';

import 'package:catalog_getx/src/data/repository.dart';
import 'package:get/get.dart';
import 'package:paint_collection/paint_collection.dart';

class CatalogController extends GetxController with StateMixin<List<Item>> {
  late final Repository _repo;

  StreamSubscription<Item>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _repo = Get.find();
    value = [];
  }

  @override
  void onReady() async {
    super.onReady();
    await refreshCatalog();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  Future<void> refreshCatalog() async {
    _subscription?.cancel();
    _repo.clearCatalog();
    setEmpty();
    _subscription = _repo.loadCatalog().listen(_repo.addToCatalog);
    setLoading();
    await _subscription?.asFuture();
    setSuccess(_repo.catalogItems);
  }
}
