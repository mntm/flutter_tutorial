import 'package:api_fetch_bloc/src/users/data/user_api_requests.dart';
import 'package:api_fetch_bloc/src/users/models/user.dart';

class UserRepository {
  final UserApiRequests _fetch = UserApiRequests();
  final Map<int, User> _cache = {};

  Future<User> getUserById(int id) async {
    try {
      if (_cache[id] == null) {
        final user = await _fetch.getUserById(id);
        _cache[id] = user;
      }
      return _cache[id]!;
    } catch (e) {
      throw Exception("Error: Get User #$id -- ${e.toString()}");
    }
  }
}
