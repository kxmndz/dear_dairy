import 'package:dear_dairy/AppContext.dart';
import 'package:dear_dairy/common_appbar.dart' show bar;
import 'package:flutter/material.dart';

import 'DairyDrawerStateful.dart';

class DairyAboutPage extends StatefulWidget {
  const DairyAboutPage({super.key});

  @override
  State<DairyAboutPage> createState() => _DairyAboutPageState();
}

void _deleteAllEntries(BuildContext context, AppContext app_ctx) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete ALL entries?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
              app_ctx.entries = [];
            },
          ),
        ],
      );
    },
  );
}


class _DairyAboutPageState extends State<DairyAboutPage> {
  @override
  Widget build(BuildContext context) {
    final AppContext app_ctx =
        ModalRoute.of(context)!.settings.arguments as AppContext;
    return Scaffold(
      appBar: bar,
      drawer: DairyDrawer(app_ctx: app_ctx),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(title: Text('Logged in as ${app_ctx.username}')),

            Divider(),

            Row(
              children: [
                Text(
                  'Total number of entries added: ${app_ctx.entries.length}',
                ),

                const Spacer(),

                TextButton(
                  child: Text('Delete all entries?'),
                  onPressed: () => _deleteAllEntries(context, app_ctx),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
