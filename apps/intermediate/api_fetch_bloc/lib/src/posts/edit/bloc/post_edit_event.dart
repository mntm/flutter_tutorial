part of 'post_edit_bloc.dart';

sealed class PostEditEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostEditRequested extends PostEditEvent {
  final PostModificationPayload payload;

  PostEditRequested(this.payload);

  @override
  List<Object?> get props => super.props..add(payload);
}
