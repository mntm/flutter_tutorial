import 'package:api_fetch_bloc/api/utils/utils.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';

class PostRepository {
  final NetworkRequestsHelper nethelper = NetworkRequestsHelper();

  Future<List<PostItem>> getItems({int startIndex = 0, int limit = 20}) async {
    List<PostItem> items = [];
    try {
      final response = await nethelper.performGet(Uri.parse(
              "https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit"))
          as List<dynamic>;
      items = response.map(PostItem.formJson).toList();
    } catch (e) {
      throw FormatException("Bad response format: ${e.toString()}");
    }
    return items;
  }

  Future<PostItem> createItem(PostCreationPayload item) async {
    try {
      final response = await nethelper.performModifyingRequest(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        method: ModifyingHttpMethod.post,
        data: item,
      );
      return PostItem.formJson(response);
    } catch (e) {
      throw Exception("Create Item: ${e.toString()}");
    }
  }

  Future<PostItem> modifyItem(PostModificationPayload item) async {
    try {
      final response = await nethelper.performModifyingRequest(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/${item.id}"),
        method: ModifyingHttpMethod.put,
        data: item,
      );
      return PostItem.formJson(response);
    } catch (e) {
      throw Exception("Modify Item: ${e.toString()}");
    }
  }

  Future<void> deleteItem(PostModificationPayload item) async {
    try {
      await nethelper.performModifyingRequest(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/${item.id}"),
        method: ModifyingHttpMethod.delete,
        data: item,
      );
    } catch (e) {
      throw Exception("Delete Item: ${e.toString()}");
    }
  }
}
