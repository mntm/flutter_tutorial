import 'package:catalog_getx/src/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app.dart';

void main() {
  Get.lazyPut<Repository>(
    () => Repository(),
  );
  runApp(
    const MainApp(),
  );
}
