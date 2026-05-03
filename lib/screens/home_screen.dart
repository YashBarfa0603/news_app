import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/Widget/card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'General',
      'Technology',
      'Business',
      'Sports',
      'Health',
      'Science',
      'Entertainment',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NEWSAPP',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return RefreshIndicator(
            onRefresh: () =>
                newsProvider.fetchNews(category: newsProvider.currentCategory),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Good Morning,',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Breaking News',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index].toLowerCase();
                        final isSelected = newsProvider.currentCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(categories[index]),
                            selected: isSelected,
                            onSelected: (val) {
                              if (val) newsProvider.fetchNews(category: cat);
                            },
                            selectedColor: Theme.of(context).primaryColor,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                if (newsProvider.isLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (newsProvider.articles.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: Text('No news found')),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final article = newsProvider.articles[index];
                      return NewsCard(
                        title: article.title,
                        description: article.description,
                        urlToImage: article.urlToImage,
                        url: article.url,
                        author: article.author,
                        publishedAt: article.publishedAt,
                        content: article.content,
                      );
                    }, childCount: newsProvider.articles.length),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
