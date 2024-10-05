import 'dart:convert';

import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/utils/api_response_handler.dart';
import 'package:api_fetch_bloc/utils/http_content_type.dart';
import 'package:api_fetch_bloc/utils/modifying_http_method.dart';
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

  Future<dynamic> _performModifyingRequest(
    Uri url, {
    required dynamic data,
    required ModifyingHttpMethod method,
    HttpContentType contentType = HttpContentType.json,
  }) async {
    Response response;
    try {
      var headers = {"content-type": contentType.value};
      response = await method.caller(_http,
          url: url, headers: headers, body: contentType.encode(data));
    } catch (e) {
      throw Exception(
          "An error occured when trying to reach the server: ${e.runtimeType} -- ${e.toString()}");
    }

    return response.statusCode.asHttpStatusCode(response);
  }

  Future<PostItem> createItem(PostCreationPayload item) async {
    try {
      var response = await _performModifyingRequest(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        method: ModifyingHttpMethod.post,
        data: item,
      );
      return PostItem(
        id: response["id"],
        userId: response["userId"],
        title: response["title"],
        body: response["body"],
      );
    } catch (e) {
      throw Exception("Create Item: ${e.toString()}");
    }
  }
}
