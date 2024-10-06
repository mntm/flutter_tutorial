import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_edit_event.dart';
part 'post_edit_state.dart';

class PostEditBloc extends Bloc<PostEditEvent, PostEditState> {
  late final PostRepository _repo;

  PostEditBloc(PostRepository repo) : super(PostEditStateInitial()) {
    _repo = repo;
    on<PostEditRequested>(_onPostEditRequested);
  }

  FutureOr<void> _onPostEditRequested(
      PostEditRequested event, Emitter<PostEditState> emit) async {
    emit(PostEditStateWaiting());
    try {
      PostItem item = await _repo.modifyItem(event.payload);
      emit(PostEditStateResolved(item));
    } catch (e) {
      emit(PostEditStateRejected(event.payload, e));
    }
  }
}
