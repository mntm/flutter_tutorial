part of 'delete_bloc.dart';

sealed class PostDeleteEvent extends ApiRequestEvent {
  @override
  List<Object?> get props => [];
}

class DeleteItemEvent extends PostDeleteEvent {
  final PostItem item;

  DeleteItemEvent(this.item);
  @override
  List<Object?> get props => super.props..add(item);
}
