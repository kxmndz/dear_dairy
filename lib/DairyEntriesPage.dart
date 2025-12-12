import 'package:dear_dairy/AppContext.dart';
import 'package:flutter/material.dart';

import 'common_drawer.dart' show makeDrawer;
import 'common_appbar.dart' show bar;

class DairyEntriesPage extends StatelessWidget {
  const DairyEntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppContext app_ctx = ModalRoute.of(context)!.settings.arguments as AppContext;
    return Scaffold(
      appBar: bar,
      drawer: makeDrawer(context),
      body: Center(child: ListView(children: app_ctx.buildCards())),
    );
  }
}
