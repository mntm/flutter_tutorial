import 'dart:math';

import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:equatable/equatable.dart';

class PostModificationPayload extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostModificationPayload({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  PostModificationPayload.from(PostItem item)
      : this(
          body: item.body,
          id: item.id,
          title: item.title,
          userId: item.userId,
        );

  @override
  String toString() {
    int bodyLength = min(body.length, 64);
    return '''PostModificationPayload -- id: $id -- title: $title -- body: ${body.substring(0, bodyLength)} -- userId: $userId''';
  }

  @override
  List<Object?> get props => [id, userId, title, body];
}
