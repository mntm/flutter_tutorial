part of 'post_edit_bloc.dart';

sealed class PostEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostEditStateInitial extends PostEditState {}

class PostEditStateWaiting extends PostEditState {}

class PostEditStateResolved extends PostEditState {
  final PostItem item;

  PostEditStateResolved(this.item);
  @override
  List<Object?> get props => super.props..add(item);
}

class PostEditStateRejected extends PostEditState {
  final PostModificationPayload failedPayload;
  final Object reason;

  PostEditStateRejected(this.failedPayload, this.reason);
  @override
  List<Object?> get props => super.props..addAll([failedPayload, reason]);
}
