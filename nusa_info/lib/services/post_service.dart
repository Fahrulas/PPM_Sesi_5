import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET /posts
  Future<List<Post>> getPosts() async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat daftar pengumuman.');
    }
  }

  // GET /posts/{id}/comments
  Future<List<dynamic>> getComments(int postId) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat komentar.');
    }
  }

  // POST /posts
  Future<Post> createPost(Post post) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal membuat pengumuman baru.');
    }
  }
}
