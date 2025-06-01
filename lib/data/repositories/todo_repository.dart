import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoRepository {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Todo>> fetchUserTodos(int userId) async {
    final url = Uri.parse('$baseUrl/todos/user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final todos = (jsonData['todos'] as List)
          .map((todoJson) => Todo.fromJson(todoJson))
          .toList();
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
