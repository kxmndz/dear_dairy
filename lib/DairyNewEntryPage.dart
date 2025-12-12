import 'package:dear_dairy/common_appbar.dart' show bar;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'common_drawer.dart' show makeDrawer;

class DairyNewEntryPage extends StatelessWidget {
  const DairyNewEntryPage({super.key});

  void _handleDream() {
    // store username from controller here
    String username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar,
      drawer: makeDrawer(context),
      body: Center(child: ListView(
        children: [
          Text("Today's date: ${DateFormat.yMMMMd().format(DateTime.now())}"),

          Divider(),

          TextField(
            decoration: InputDecoration(
                hintText: 'I had a dream about...',
                contentPadding: EdgeInsets.all(20)
            )
          ),

          OutlinedButton(
            onPressed: () => _handleDream(),
            child: Text('Add Entry'),
          ),
        ],
      )),
    );
  }
}