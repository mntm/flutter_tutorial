import 'package:catalog_bloc/src/catalog/catalog.dart';
import 'package:catalog_bloc/src/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    Repository repo = context.read<Repository>();
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CatalogBloc(repo))],
      child: const CatalogScreen(),
    );
  }
}
