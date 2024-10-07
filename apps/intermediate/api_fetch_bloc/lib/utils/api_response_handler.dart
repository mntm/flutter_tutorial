import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'http_content_type.dart';

class HttpException implements Exception {
  final String message;
  final int code;
  HttpException(this.message, this.code);

  @override
  String toString() => 'HttpException: $message';
}

typedef TResponseHandler = FutureOr<dynamic> Function(Response response);

class ApiResponseHandler {
  static final ApiResponseHandler _instance = ApiResponseHandler._internal();
  final Map<int, TResponseHandler> _handlers = {};
  ApiResponseHandler._internal() {
    _handlers.addAll({
      200: _handle200,
      201: _handle201,
      204: _handle204,
      301: _handle301,
      302: _handle302,
      400: _handle400,
      401: _handle401,
      403: _handle403,
      404: _handle404,
      500: _handle500,
      502: _handle502,
      503: _handle503,
    });
  }

  factory ApiResponseHandler() {
    return _instance;
  }

  Future<dynamic> handle(Response response) async {
    TResponseHandler handler = _handlers[response.statusCode] ?? _handleUnknown;
    return await handler(response);
  }

  void addHandler(int statusCode, TResponseHandler handler) {
    _handlers[statusCode] = handler;
  }

  FutureOr<void> _handleUnknown(Response response) {
    throw HttpException(
        'Unexpected status code: ${response.statusCode}', response.statusCode);
  }

  FutureOr<dynamic> _handle200(Response response) {
    HttpContentType contentType =
        HttpContentType.of(response.headers["content-type"]);
    return contentType.decode(response.body);
  }

  FutureOr<dynamic> _handle201(Response response) {
    debugPrint('Resource created: ${response.body}');
    return _handle200(response);
  }

  FutureOr<void> _handle204(Response response) {
    debugPrint('No content returned.');
  }

  FutureOr<void> _handle301(Response response) {
    debugPrint('Redirected permanently to: ${response.headers['Location']}');
  }

  FutureOr<void> _handle302(Response response) {
    debugPrint('Redirected temporarily to: ${response.headers['Location']}');
  }

  FutureOr<void> _handle400(Response response) {
    throw HttpException('Bad request: ${response.body}', 400);
  }

  FutureOr<void> _handle401(Response response) {
    throw HttpException('Unauthorized: ${response.body}', 401);
  }

  FutureOr<void> _handle403(Response response) {
    throw HttpException('Forbidden: ${response.body}', 403);
  }

  FutureOr<void> _handle404(Response response) {
    throw HttpException('Not found: ${response.body}', 404);
  }

  FutureOr<void> _handle500(Response response) {
    throw HttpException('Internal server error: ${response.body}', 500);
  }

  FutureOr<void> _handle502(Response response) {
    throw HttpException('Bad gateway: ${response.body}', 502);
  }

  FutureOr<void> _handle503(Response response) {
    throw HttpException('Service unavailable: ${response.body}', 503);
  }
}

extension HttpCodeHandlerExtension on int {
  FutureOr<dynamic> asHttpStatusCode(Response response) async {
    ApiResponseHandler handler = ApiResponseHandler();
    return handler.handle(response);
  }
}
