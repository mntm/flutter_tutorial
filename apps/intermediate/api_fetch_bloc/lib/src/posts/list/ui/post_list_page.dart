import 'package:api_fetch_bloc/src/posts/create/ui/ui.dart';
import 'package:api_fetch_bloc/src/posts/list/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_list_view.dart';

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
        floatingActionButton: const AddNewPostWidget(),
      ),
    );
  }
}

class AddNewPostWidget extends StatelessWidget {
  const AddNewPostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        var result = await showAdaptiveDialog(
          context: context,
          builder: (context) => const NewFormPage(),
        );

        if (result != null && context.mounted) {
          context.read<PostBloc>().add(PostInserted(result));
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
