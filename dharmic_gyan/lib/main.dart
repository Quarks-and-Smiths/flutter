import 'dart:convert';

import 'package:dharmic_gyan/pages/author_page.dart';
import 'package:dharmic_gyan/pages/home_page.dart';
import 'package:dharmic_gyan/pages/search_page.dart';
import 'package:dharmic_gyan/pages/settings_page.dart';
import 'package:dharmic_gyan/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  // Initialize data
  await isarService.loadAuthorsFromJson();
  await isarService.loadQuotesWithAuthors();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => isarService),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/settings': (context) => const SettingsPage(), // Define the route here
        '/searchpage': (context) => const SearchPage(), // Define the route here
        '/author': (context) => const AuthorPage(),

        // Define the route here
      },
    );
  }
}
