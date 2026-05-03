import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleDetailScreen extends StatelessWidget {
  final NewsModel article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: article.urlToImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.grey),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Politics', // Placeholder for category
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=author'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.author,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            article.publishedAt.isNotEmpty 
                              ? '${timeago.format(DateTime.parse(article.publishedAt))} • 5 min read'
                              : '5 min read',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.content.replaceAll(RegExp(r'\[\+\d+ chars\]'), ''),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final uri = Uri.parse(article.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Read Full Article'),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
