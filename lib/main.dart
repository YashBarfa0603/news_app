import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:news_app/screens/homepage.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsProvider())],
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Homepage(),
    );
  }
}
