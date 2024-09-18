import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/post_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "post_event.dart";
part "post_state.dart";

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.repo)
      : super(const PostState(status: PostStatus.initial, hasNext: true)) {
    on<PostRequested>(_onPostRequested);
  }

  final PostRepository repo;

  Future<void> _onPostRequested(
      PostRequested event, Emitter<PostState> emit) async {
    if (!state.hasNext) return;
    try {
      int limit = 18;
      var items =
          await repo.getItems(limit: limit, startIndex: state.posts.length);

      emit(
        items.isEmpty
            ? state.copyWith(
                hasNext: false,
              )
            : state.copyWith(
                status: PostStatus.success,
                hasNext: items.length == limit,
                posts: List.of(state.posts)..addAll(items)),
      );
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure, hasNext: false));
    }
  }
}
