import 'package:flutter/material.dart';
import 'package:flutter_ui/core/presentation/pages/dashboard_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analytics Dashboard',
      theme: AppTheme.darkTheme,
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}