import 'package:api_fetch_bloc/api/utils/utils.dart';
import 'package:http/http.dart';

class NetworkRequestsHelper {
  static final NetworkRequestsHelper _instance =
      NetworkRequestsHelper._internal();

  final Client _http = Client();
  NetworkRequestsHelper._internal();
  factory NetworkRequestsHelper() {
    return _instance;
  }

  Future<dynamic> performGet(Uri url) async {
    Response response;
    try {
      response = await _http.get(url);
    } catch (e) {
      throw Exception(
          "An error occured when trying to reach the server: ${e.runtimeType} -- ${e.toString()}");
    }
    return response.statusCode.asHttpStatusCode(response);
  }

  Future<dynamic> performModifyingRequest(
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
}
