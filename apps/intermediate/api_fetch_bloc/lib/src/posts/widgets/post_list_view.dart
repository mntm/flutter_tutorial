import 'package:api_fetch_bloc/src/posts/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListView extends StatelessWidget {
  const PostListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state.status == PostStatus.initial) {
        context.read<PostBloc>().add(PostRequested());
        return const Center(child: Text("Loading ..."));
      }
      return GridView.builder(
          itemCount:
              state.hasNext ? state.posts.length + 1 : state.posts.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisExtent: 120,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            if (index >= state.posts.length) {
              context.read<PostBloc>().add(PostRequested());
              return Text("Loading...");
            }
            return PostItemTile(item: state.posts[index]);
          });
    });
  }
}
