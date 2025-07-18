import 'package:flutter/material.dart';

import 'package:news_app/screen/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
