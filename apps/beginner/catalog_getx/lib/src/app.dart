import 'package:catalog_getx/constants.dart';
import 'package:catalog_getx/src/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Repository repository = Repository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenRoutes.homeDestination.page(context, null),
        getPages: [
          GetPage(
            name: ScreenRoutes.homeDestination.uri,
            page: () => ScreenRoutes.homeDestination.page(context, null),
          ),
          GetPage(
            name: ScreenRoutes.cartDestination.uri,
            page: () => ScreenRoutes.cartDestination.page(context, null),
          ),
        ]);
  }
}
