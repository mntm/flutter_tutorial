import 'dart:convert';

class _HtmlEscapeCodec extends Codec<String, dynamic> {
  const _HtmlEscapeCodec();
  @override
  Converter<dynamic, String> get decoder => htmlEscape;

  @override
  Converter<String, dynamic> get encoder => htmlEscape;
}

enum HttpContentType implements Comparable<HttpContentType> {
  json("application/json", JsonCodec()),
  raw("application/octet-stream", Utf8Codec()),
  text("text/plain", _HtmlEscapeCodec());

  const HttpContentType(this.value, this.transformer);
  final String value;
  final Codec transformer;

  String encode(dynamic obj) => transformer.encode(obj);

  dynamic decode(String str) => transformer.decode(str);

  @override
  int compareTo(HttpContentType other) => value.compareTo(other.value);

  static HttpContentType of(String? value) {
    if (value == null) return raw;
    String realtype = value.split(";")[0].trim();
    return HttpContentType.values
        .firstWhere((elt) => elt.value == realtype, orElse: () => raw);
  }
}
