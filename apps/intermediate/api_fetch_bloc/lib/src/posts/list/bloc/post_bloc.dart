import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/post_item.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part "post_event.dart";
part "post_state.dart";

/// throttle events by dropping events emitted during [duration].
/// No event is emitted during [duration]
EventTransformer<E> throttleEvents<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.repo)
      : super(const PostState(status: PostStatus.initial, hasNext: true)) {
    on<PostRequested>(_onPostRequested,
        transformer: throttleEvents(const Duration(milliseconds: 300)));
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
