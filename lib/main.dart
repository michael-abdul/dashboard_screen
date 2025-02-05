import 'package:flutter/material.dart';
import 'package:flutter_ui/core/presentation/pages/dashboard_page.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Web yoki Desktop ekanligini tekshirish
  if (!kIsWeb) {  // Agar web EMAS bo'lsa
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowMinSize(const Size(1024, 768));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analytics Dashboard',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Container(
          constraints: const BoxConstraints(
            minWidth: 1024,
            minHeight: 768,
          ),
          child: child!,
        );
      },
      home: const DashboardPage(),
    );
  }
}