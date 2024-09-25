import 'dart:math';

import 'package:equatable/equatable.dart';

class PostCreationPayload extends Equatable {
  final int userId;
  final String title;
  final String body;

  const PostCreationPayload({
    required this.userId,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {"userId": userId, "title": title, "body": body};
  }

  const PostCreationPayload.flexible({
    int? userId,
    String? title,
    String? body,
  }) : this(
          body: body ?? "",
          title: title ?? "New post",
          userId: userId ?? 1,
        );

  PostCreationPayload copyWith({
    int? userId,
    String? title,
    String? body,
  }) {
    return PostCreationPayload(
      body: body ?? this.body,
      title: title ?? this.title,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    int bodyLength = min(body.length, 64);
    return '''PostCreationPayload -- title: $title -- body: ${body.substring(0, bodyLength)} -- userId: $userId''';
  }

  @override
  List<Object?> get props => [userId, title, body];
}
