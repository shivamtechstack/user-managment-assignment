import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostRepository {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Post>> fetchUserPosts(int userId) async {
    final url = Uri.parse('$baseUrl/posts/user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final posts = (jsonData['posts'] as List)
          .map((postJson) => Post.fromJson(postJson))
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
