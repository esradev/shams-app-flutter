import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/post.dart';

class ApiService {
  final String baseUrl = "https://shams-almaarif.com/wp-json/wp/v2";

  Future<List<Category>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('$baseUrl/categories?per_page=20'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // Filter categories with posts (count > 0)
      final filteredData = data.where((json) => json['count'] > 0).toList();
      return filteredData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Post>> fetchPostsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/posts?categories=$categoryId&_embed=true&per_page=99'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
