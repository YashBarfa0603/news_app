import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/article_detail_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String author;
  final String publishedAt;
  final String content;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.author,
    required this.publishedAt,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final article = NewsModel(
      title: title,
      description: description,
      urlToImage: urlToImage,
      url: url,
      author: author,
      publishedAt: publishedAt,
      content: content,
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (urlToImage.isNotEmpty)
              CachedNetworkImage(
                imageUrl: urlToImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[100],
                  child: const Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          author,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        publishedAt.isNotEmpty 
                          ? timeago.format(DateTime.parse(publishedAt))
                          : '',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<NewsProvider>(
                        builder: (context, provider, _) {
                          final isSaved = provider.isBookmarked(article);
                          return IconButton(
                            onPressed: () => provider.toggleBookmark(article),
                            icon: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: isSaved ? Theme.of(context).primaryColor : Colors.grey,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {}, // Share logic
                        icon: const Icon(Icons.share_outlined, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}