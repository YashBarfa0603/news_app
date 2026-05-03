import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Technology', 'icon': Icons.computer, 'color': Colors.blue},
      {'name': 'Business', 'icon': Icons.business_center, 'color': Colors.orange},
      {'name': 'Sports', 'icon': Icons.sports_basketball, 'color': Colors.green},
      {'name': 'Health', 'icon': Icons.health_and_safety, 'color': Colors.red},
      {'name': 'Science', 'icon': Icons.science, 'color': Colors.purple},
      {'name': 'Entertainment', 'icon': Icons.movie, 'color': Colors.pink},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search news, topics...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Browse Categories', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 30),
                        const SizedBox(height: 8),
                        Text(
                          cat['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
