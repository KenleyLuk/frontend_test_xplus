import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/swap/presentation/pages/swap_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swap App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SwapPage(),
    );
  }
}