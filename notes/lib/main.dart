import 'package:flutter/material.dart';
import 'package:notes/screens/NotesScreen.dart';
import 'package:notes/screens/note_screen.dart';

import 'app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes app',
      theme: appTheme,
      routes: {
        NotesScreen.route: (context) => const NotesScreen(),
        NoteScreen.route: (context) => const NoteScreen()
      },
      initialRoute: NotesScreen.route,
    );
  }
}
