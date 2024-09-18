import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';

void main() {
  runApp(
    RepositoryProvider(
      lazy: true,
      create: (BuildContext context) {
        return PostRepository();
      },
      child: const App(),
    ),
  );
}
