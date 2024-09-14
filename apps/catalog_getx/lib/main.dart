import 'package:catalog_getx/src/cart/cart.dart';
import 'package:catalog_getx/src/catalog/catalog_controller.dart';
import 'package:catalog_getx/src/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app.dart';

void main() {
  Get.lazyPut<Repository>(() => Repository());
  Get.lazyPut<CatalogController>(() => CatalogController());
  Get.lazyPut<CartController>(() => CartController());
  runApp(
    const MainApp(),
  );
}
