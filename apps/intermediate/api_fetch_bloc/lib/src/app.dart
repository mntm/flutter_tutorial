import 'package:api_fetch_bloc/src/posts/bloc/post_bloc.dart';
import 'package:api_fetch_bloc/src/posts/ui/post_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(Client()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostListPage(),
      ),
    );
  }
}
