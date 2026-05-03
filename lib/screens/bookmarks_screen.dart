import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/Widget/card.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No saved articles yet',
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: newsProvider.bookmarks.length,
            itemBuilder: (context, index) {
              final article = newsProvider.bookmarks[index];
              return NewsCard(
                title: article.title,
                description: article.description,
                urlToImage: article.urlToImage,
                url: article.url,
                author: article.author,
                publishedAt: article.publishedAt,
                content: article.content,
              );
            },
          );
        },
      ),
    );
  }
}
