import 'dart:async';

import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class CreateNewPostBloc extends Bloc<CreateNewPostEvent, CreateNewPostState> {
  final PostRepository repo;
  CreateNewPostBloc(this.repo) : super(CreateNewPostStateInitial()) {
    on<CreateNewPostSubmitted>(_onSubmitted);
  }

  FutureOr<void> _onSubmitted(
      CreateNewPostSubmitted event, Emitter<CreateNewPostState> emit) async {
    emit(CreateNewPostStateWaiting());
    await Future.delayed(const Duration(seconds: 2));
    try {
      var result = await repo.createItem(event.payload);
      emit(CreateNewPostStateResolved(result));
    } catch (e) {
      emit(CreateNewPostStateRejected(e as Exception));
    }
  }
}
