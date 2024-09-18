import 'dart:async';
import 'dart:convert';

import 'package:api_fetch_bloc/src/posts/models/post_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part "post_event.dart";
part "post_state.dart";

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.httpClient)
      : super(const PostState(status: PostStatus.initial, hasNext: true)) {
    on<PostRequested>(_onPostRequested);
  }

  final http.Client httpClient;

  Future<void> _onPostRequested(
      PostRequested event, Emitter<PostState> emit) async {
    if (!state.hasNext) return;

    int limit = 18;
    http.Response response = await httpClient.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_start=${state.posts.length}&_limit=$limit"));

    if (response.statusCode != 200) {
      throw Exception("error while fetching posts");
    }

    List<dynamic> json = jsonDecode(response.body) as List;
    List<PostItem> items = json
        .map(
          (elt) => PostItem(
              id: elt["id"] as int,
              userId: elt["userId"] as int,
              title: elt["title"] as String,
              body: elt["body"] as String),
        )
        .toList();

    emit(
      items.isEmpty
          ? state.copyWith(
              hasNext: false,
            )
          : state.copyWith(
              status: PostStatus.success,
              hasNext: items.length == limit,
              posts: List.of(state.posts)..addAll(items)),
    );
  }
}
