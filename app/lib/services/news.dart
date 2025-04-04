import 'dart:convert';

import 'package:app/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/news.dart';

class NewsService {
  static const String baseUrl =
      'https://news-app-flutter-express-js.vercel.app/api';

  static Future<List<CategoryModel>> getCategires() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<CategoryModel>.from(
          data["data"].map((x) => CategoryModel.fromJson(x)));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<NewModel>> getNews(
      {String? category = "", int? page = 2}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/news?category=${category != null ? category.toLowerCase() : ""}&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<NewModel>.from(data["data"].map((x) => NewModel.fromJson(x)));
    } else {
      throw Exception('Failed to load nesws');
    }
  }
}
