import 'package:flutter/material.dart';

import 'screens/site_list_screen.dart';

void main() {
  runApp(const BrixtaApp());
}

class BrixtaApp extends StatelessWidget {
  const BrixtaApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Brixta',

      theme: ThemeData(

        useMaterial3: true,

        colorSchemeSeed: Colors.blue,

        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),

        inputDecorationTheme:
            const InputDecorationTheme(

          border: OutlineInputBorder(),

          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),

      home: const SiteListScreen(),
    );
  }
}