import 'dart:math';

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

  PostItem.formJson(dynamic json)
      : this(
          id: json["id"],
          userId: json["userId"],
          title: json["title"],
          body: json["body"],
        );

  PostItem copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return PostItem(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.title);
  }

  @override
  String toString() {
    int bodyLength = min(body.length, 64);
    return '''PostItem -- id: $id -- title: $title -- body: ${body.substring(0, bodyLength)} -- userId: $userId''';
  }

  @override
  List<Object?> get props => [id, userId, title, body];
}
