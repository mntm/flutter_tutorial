import 'package:catalog_getx/constants.dart';
import 'package:catalog_getx/src/data/repository.dart';
import 'package:flutter/material.dart';

final Repository repository = Repository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenRoutes.homeDestination.page(context, null),
    );
  }
}
