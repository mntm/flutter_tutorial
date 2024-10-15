import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/api/bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class CreateNewPostBloc extends Bloc<CreateNewPostEvent, ApiRequestState> {
  final PostRepository repo;
  CreateNewPostBloc(this.repo) : super(ApiRequestStateInitial()) {
    on<CreateNewPostSubmitted>(_onSubmitted);
  }

  FutureOr<void> _onSubmitted(
      CreateNewPostSubmitted event, Emitter<ApiRequestState> emit) async {
    emit(ApiRequestStateWaiting());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await repo.createItem(event.payload);
      emit(ApiRequestStateResolved(result));
    } catch (e) {
      emit(ApiRequestStateRejected(event.payload, e as Exception));
    }
  }
}
