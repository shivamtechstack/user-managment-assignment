import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import '../models/todo_model.dart';
import '../models/user_model.dart';

class UserApiProvider {
  final baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers({int limit = 10, int skip = 0}) async {
    final response = await http.get(Uri.parse('$baseUrl/users?limit=$limit&skip=$skip'));
    if (response.statusCode == 200) {
      final List users = json.decode(response.body)['users'];
      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<User>> searchUsers(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/users/search?q=$query'));
    if (response.statusCode == 200) {
      final List users = json.decode(response.body)['users'];
      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }

  Future<List<Post>> fetchPosts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['posts'] as List;
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Todo>> fetchTodos(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['todos'] as List;
      return data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

}