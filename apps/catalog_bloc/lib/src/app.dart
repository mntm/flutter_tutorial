import 'package:catalog_bloc/constants.dart';
import 'package:catalog_bloc/src/cart/bloc/cart_cubit.dart';
import 'package:catalog_bloc/src/catalog/catalog.dart';
import 'package:catalog_bloc/src/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: ScreenRoutes.homeDestination.uri,
      builder: ScreenRoutes.homeDestination.page,

      /// uses subroute to enable animation between screens
      /// and automatically add a back button on the AppBar
      routes: [
        GoRoute(
            path: ScreenRoutes.cartDestination.uri,
            builder: ScreenRoutes.cartDestination.page,
            name: ScreenRoutes.cartDestination.uri)
      ],
    ),
  ],
);

final Repository repository = Repository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CatalogBloc(repository)),
        BlocProvider(create: (_) => CartCubit(repository))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
