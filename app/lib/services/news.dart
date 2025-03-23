import 'dart:convert';

import 'package:app/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/news.dart';

class NewsService {
  static const String baseUrl = 'http://127.0.0.1:4500/api';

  static Future<List<CategoryModel>> getCategires() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    print("-------------------  ");
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<CategoryModel>.from(
          data["data"].map((x) => CategoryModel.fromJson(x)));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<NewModel>> getNews({String? category}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/news${category != null ? '?category=${category.toLowerCase()}' : ''}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<NewModel>.from(data["data"].map((x) => NewModel.fromJson(x)));
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
