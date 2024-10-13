import 'package:api_fetch_bloc/api/utils/utils.dart';
import 'package:api_fetch_bloc/src/users/models/models.dart';

class UserRepository {
  final NetworkRequestsHelper nethelper = NetworkRequestsHelper();

  Future<User> getUserById(int id) async {
    try {
      final response = await nethelper.performGet(
          Uri.parse("https://jsonplaceholder.typicode.com/users/$id"));
      return User.fromJson(response);
    } catch (e) {
      throw Exception("Error: Get User #$id -- ${e.toString()}");
    }
  }
}
