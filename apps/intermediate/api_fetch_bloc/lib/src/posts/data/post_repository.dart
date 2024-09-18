import 'dart:convert';

import 'package:api_fetch_bloc/src/posts/models/post_item.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class PostRepository {
  final Client _http = Client();

  Future<List<PostItem>> getItems({int startIndex = 0, int limit = 20}) async {
    List<PostItem> items = [];
    Response response = await _performGet(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit"));
    if (response.statusCode != 200) {
      throw Exception("error while fetching posts");
    }
    items = _decodeResponseForItems(response);
    return items;
  }

  List<PostItem> _decodeResponseForItems(Response response) {
    List<PostItem> items = [];
    try {
      List<dynamic> json = jsonDecode(response.body) as List;
      items = json
          .map(
            (elt) => PostItem(
                id: elt["id"] as int,
                userId: elt["userId"] as int,
                title: elt["title"] as String,
                body: elt["body"] as String),
          )
          .toList();
    } catch (e) {
      debugPrintStack();
      throw const FormatException("Bad response format");
    }
    return items;
  }

  Future<Response> _performGet(Uri url) async {
    try {
      Response response;
      response = await _http.get(url);
      return response;
    } catch (e) {
      throw Exception(
          "An error occured when trying to reach the server: ${e.runtimeType} -- ${e.toString()}");
    }
  }
}
