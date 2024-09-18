import 'package:equatable/equatable.dart';

class PostItem extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, userId, title, body];
}
