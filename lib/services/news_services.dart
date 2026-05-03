import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class NewsServices {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsModel>> fetchTopHeadlines({String category = 'general'}) async {
    final url = Uri.parse('$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'] ?? [];
      return articles
          .map((article) => NewsModel.fromJson(article))
          .where((article) => article.title != '[Removed]') // Filter removed articles
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
  Future<NewsModel> fetchNewsByUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsModel.fromJson(data);
    } else {
      throw Exception('Failed to load news');
    }
  }
}