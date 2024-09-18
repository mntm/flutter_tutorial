import 'package:api_fetch_bloc/src/posts/bloc/post_bloc.dart';
import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        PostRepository repo = RepositoryProvider.of<PostRepository>(context);
        return PostBloc(repo)..add(PostRequested());
      },
      child: Scaffold(
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
      ),
    );
  }
}
