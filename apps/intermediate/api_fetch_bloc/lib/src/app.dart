import 'package:api_fetch_bloc/src/posts/list/ui/ui.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: const AddNewPostWidget(),
      body: const SafeArea(
        child: PostListPage(),
      ),
    );
  }
}
