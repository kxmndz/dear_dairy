import 'package:flutter/material.dart';

import 'DairyAboutPage.dart';
import 'DairyEntriesStateful.dart';
import 'DairyLoginStateful.dart';
import 'DairyNewEntryStateful.dart';

void main() {
  runApp(const DairyApp());
}

class DairyApp extends StatelessWidget {
  const DairyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DearDairy',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.brown)),
      home: const DairyLoginPage(),
      routes: {
        '/login':   (BuildContext ctx) => DairyLoginPage(),
        '/new':     (BuildContext ctx) => DairyNewEntryPage(),
        '/entries': (BuildContext ctx) => DairyEntriesPage(),
        '/about':   (BuildContext ctx) => DairyAboutPage(),
      },
    );
  }
}
