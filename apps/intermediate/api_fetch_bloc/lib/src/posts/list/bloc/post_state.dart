part of 'post_bloc.dart';

class PostState extends Equatable {
  final RequestStatus status;
  final bool hasNext;
  final List<PostItem> posts;

  const PostState({
    required this.status,
    required this.hasNext,
    this.posts = const [],
  });

  @override
  List<Object?> get props => [status, hasNext, posts];

  PostState copyWith({
    RequestStatus? status,
    bool? hasNext,
    List<PostItem>? posts,
  }) {
    return PostState(
      status: status ?? this.status,
      hasNext: hasNext ?? this.hasNext,
      posts: posts ?? this.posts,
    );
  }
}
