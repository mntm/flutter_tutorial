import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/utils/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_edit_event.dart';

class PostEditBloc extends Bloc<PostEditEvent, ApiRequestState> {
  late final PostRepository _repo;

  PostEditBloc(PostRepository repo) : super(ApiRequestStateInitial()) {
    _repo = repo;
    on<PostEditRequested>(_onPostEditRequested);
  }

  FutureOr<void> _onPostEditRequested(
      PostEditRequested event, Emitter<ApiRequestState> emit) async {
    emit(ApiRequestStateWaiting());
    try {
      PostItem item = await _repo.modifyItem(event.payload);
      emit(ApiRequestStateResolved(item));
    } catch (e) {
      emit(ApiRequestStateRejected(event.payload, e));
    }
  }
}
