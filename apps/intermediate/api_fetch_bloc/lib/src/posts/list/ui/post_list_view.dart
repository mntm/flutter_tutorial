import 'package:api_fetch_bloc/src/posts/list/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:api_fetch_bloc/utils/request_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListView extends StatefulWidget {
  const PostListView({
    super.key,
  });

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  final ScrollController _controller = ScrollController();

  bool get _isBottom {
    if (!_controller.hasClients) return false;
    double maxScrollExtent = _controller.position.maxScrollExtent;
    double currentPosition = _controller.offset;

    return currentPosition >= (maxScrollExtent * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state.status == RequestStatus.initial) {
        return const Center(child: Text("Loading ..."));
      }
      if (state.status == RequestStatus.failure) {
        return const Center(child: Text("An error occured"));
      }
      if (state.posts.isEmpty) {
        return const Center(child: Text("No post available"));
      }
      return GridView.builder(
          controller: _controller,
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
              return const Text("Loading...");
            }
            return PostItemTile(item: state.posts[index]);
          });
    });
  }

  void _onScroll() {
    if (_isBottom) {
      /// Note: `context` is available from anywhere inside
      /// a **StatefullWidget**
      context.read<PostBloc>().add(PostRequested());
    }
  }
}
