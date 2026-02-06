import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/navigation/main_nav_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Academic Assistant',
      theme: AppTheme.lightTheme,
      home: const MainNavWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
