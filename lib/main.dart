import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/guide_page.dart';
import 'pages/privacy_page.dart';

void main() {
  runApp(const FoodPickerApp());
}

class FoodPickerApp extends StatelessWidget {
  const FoodPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '今天吃啥',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE67E22), // 暖橙色，食欲感
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/guide': (context) => const GuidePage(),
        '/privacy': (context) => const PrivacyPage(),
      },
    );
  }
}
