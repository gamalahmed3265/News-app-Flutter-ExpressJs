import 'package:app/model/category.dart';
import 'package:app/model/news.dart';
import 'package:app/services/news.dart';
import 'package:flutter/material.dart';

class NewsProviders with ChangeNotifier {
  List<NewModel> _news = [];
  List<CategoryModel> _categories = [];
  String _selectedCategory = 'all';
  bool _isLoading = false;
  List<NewModel> get news => _news;
  List<CategoryModel> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await NewsService.getCategires();
    } catch (e) {
      print(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNews({String? category, int? page}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _news = await NewsService.getNews(category: category, page: page);
    } catch (e) {
      print(e);
    }
    _isLoading = false;
    notifyListeners();
  }
}
