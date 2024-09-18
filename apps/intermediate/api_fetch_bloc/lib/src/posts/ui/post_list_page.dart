import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

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
          backgroundColor: Colors.blue),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: PostListView(),
      ),
    );
  }
}
