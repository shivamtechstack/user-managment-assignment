import '../models/user_model.dart';
import '../providers/user_api_provider.dart';

class UserRepository {
  final UserApiProvider apiProvider;

  UserRepository({required this.apiProvider});

  Future<List<User>> getUsers({int limit = 10, int skip = 0}) {
    return apiProvider.fetchUsers(limit: limit, skip: skip);
  }

  Future<List<User>> searchUsers(String query) {
    return apiProvider.searchUsers(query);
  }
}