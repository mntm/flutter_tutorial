import 'dart:async';

import 'package:api_fetch_bloc/api/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/users/data/data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class UserBloc extends Bloc<UserListEvent, ApiRequestState> {
  final UserRepository _repo;
  UserBloc(this._repo) : super(ApiRequestStateInitial()) {
    on<UserRequestByIdEvent>(_onRequestById);
  }

  FutureOr<void> _onRequestById(
      UserRequestByIdEvent event, Emitter<ApiRequestState> emit) async {
    emit(ApiRequestStateWaiting());
    try {
      final user = await _repo.getUserById(event.id);
      emit(ApiRequestStateResolved(user));
    } catch (e) {
      emit(ApiRequestStateRejected(event.id, e));
    }
  }
}

sealed class UserListEvent extends Equatable {}

class UserRequestByIdEvent extends UserListEvent {
  final int id;

  UserRequestByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}
