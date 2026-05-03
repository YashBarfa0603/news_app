import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/services/news_services.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> _articles = [];
  bool _isLoading = false;
  String _currentCategory = 'general';
  final List<NewsModel> _bookmarks = [];

  List<NewsModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String get currentCategory => _currentCategory;
  List<NewsModel> get bookmarks => _bookmarks;

  final NewsServices _newsServices = NewsServices();

  Future<void> fetchNews({String category = 'general'}) async {
    _isLoading = true;
    _currentCategory = category;
    notifyListeners();

    try {
      _articles = await _newsServices.fetchTopHeadlines(category: category);
    } catch (e) {
      debugPrint('Error fetching news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleBookmark(NewsModel article) {
    if (isBookmarked(article)) {
      _bookmarks.removeWhere((item) => item.url == article.url);
    } else {
      _bookmarks.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(NewsModel article) {
    return _bookmarks.any((item) => item.url == article.url);
  }
}
