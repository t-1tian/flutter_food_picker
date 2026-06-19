import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'theme/app_theme.dart';

class TodayEatApp extends StatelessWidget {
  const TodayEatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '今天吃啥',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
