part of "new_post_bloc.dart";

sealed class CreateNewPostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewPostStateInitial extends CreateNewPostState {}

class CreateNewPostStateWaiting extends CreateNewPostState {}

class CreateNewPostStateResolved extends CreateNewPostState {
  final PostItem item;

  CreateNewPostStateResolved(this.item);
  @override
  List<Object?> get props => super.props..add(item);
}

class CreateNewPostStateRejected extends CreateNewPostState {
  final Exception error;

  CreateNewPostStateRejected(this.error);
  @override
  List<Object?> get props => super.props..add(error);
}
