part of "new_post_bloc.dart";

sealed class CreateNewPostEvent extends ApiRequestEvent {
  @override
  List<Object?> get props => [];
}

class CreateNewPostSubmitted extends CreateNewPostEvent {
  final PostCreationPayload payload;

  CreateNewPostSubmitted(this.payload);
  @override
  List<Object?> get props => super.props..add(payload);
}
