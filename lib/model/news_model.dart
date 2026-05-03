class NewsModel {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String content;

  NewsModel({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.author,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      author: json['author'] ?? 'Unknown Source',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'url': url,
      'author': author,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
