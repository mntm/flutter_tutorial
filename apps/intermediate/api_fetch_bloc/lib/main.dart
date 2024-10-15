import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/users/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          lazy: true,
          create: (BuildContext context) {
            return PostRepository();
          },
        ),
        RepositoryProvider(
          lazy: true,
          create: (BuildContext context) {
            return UserRepository();
          },
        ),
      ],
      child: const App(),
    ),
  );
}
