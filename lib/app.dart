import 'package:flutter/material.dart';
import 'package:news_readers/presentation/ui/screens/splash_screen.dart';

class NewsReader extends StatelessWidget {
  const NewsReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
