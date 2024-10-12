import 'dart:convert';

import 'package:http/http.dart';

typedef ModifyingHttpMethodFunction = Future<Response> Function(Client client,
    {required Uri url,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding});

enum ModifyingHttpMethod {
  delete(_deleteFn),
  patch(_patchFn),
  post(_postFn),
  put(_putFn);

  final ModifyingHttpMethodFunction caller;

  const ModifyingHttpMethod(this.caller);
}

Future<Response> _deleteFn(Client client,
    {required Uri url,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding}) {
  return client.delete(url, body: body, encoding: encoding, headers: headers);
}

Future<Response> _patchFn(Client client,
    {Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
    required Uri url}) {
  return client.patch(url, body: body, encoding: encoding, headers: headers);
}

Future<Response> _postFn(Client client,
    {Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
    required Uri url}) {
  return client.post(url, body: body, encoding: encoding, headers: headers);
}

Future<Response> _putFn(Client client,
    {Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
    required Uri url}) {
  return client.put(url, body: body, encoding: encoding, headers: headers);
}
