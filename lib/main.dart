import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_ui/core/presentation/pages/dashboard_page.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
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
      home: const DashboardWrapper(),
    );
  }
}

// Yangi wrapper widget

// Yangi wrapper widget
class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekranning balandligini olish
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Birinchi DashboardPage()
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: screenHeight, // Ekran balandligining 80% ni egallaydi
                child: const DashboardPage(),
              ),
            ),
            // Ikkinchi DashboardPage()
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: screenHeight, // Ekran balandligining 80% ni egallaydi
                child: const DashboardPage(),
              ),
            ),
            // Uchinchi DashboardPage()
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: screenHeight, // Ekran balandligining 80% ni egallaydi
                child: const DashboardPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}