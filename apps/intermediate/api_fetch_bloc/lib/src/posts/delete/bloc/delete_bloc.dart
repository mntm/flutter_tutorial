import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/api/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_delete_event.dart';

class DeleteBloc extends Bloc<PostDeleteEvent, ApiRequestState> {
  final PostRepository _repo;
  DeleteBloc(this._repo) : super(ApiRequestStateInitial()) {
    on<DeleteItemEvent>(_onDeleteItemEvent);
  }

  FutureOr<void> _onDeleteItemEvent(
      DeleteItemEvent event, Emitter<ApiRequestState> emit) async {
    emit(ApiRequestStateWaiting());
    try {
      await _repo.deleteItem(PostModificationPayload.from(event.item));
      emit(ApiRequestStateResolved(event.item));
    } catch (e) {
      debugPrint(e.toString());
      debugPrintStack();
      emit(ApiRequestStateRejected(event.item, e));
    }
  }
}
