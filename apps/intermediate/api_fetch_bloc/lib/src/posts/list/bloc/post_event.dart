part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostRequested extends PostEvent {}

class PostInserted extends PostEvent {
  final PostItem item;

  PostInserted(this.item);
  @override
  List<Object?> get props => super.props..add(item);
}

class PostRemoved extends PostEvent {
  final PostItem item;

  PostRemoved(this.item);
  @override
  List<Object?> get props => super.props..add(item);
}
