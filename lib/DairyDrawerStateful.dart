import 'package:flutter/material.dart';
import 'package:dear_dairy/AppContext.dart';

class DairyDrawer extends StatelessWidget {
  final AppContext app_ctx;

  const DairyDrawer({super.key, required this.app_ctx});

  @override
  Widget build(BuildContext context) {
    final String username = app_ctx.username;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: ListTile(
              title: const Text('Dear Dairy'),
              subtitle: Text('Logged in as $username'),
            ),
          ),

          ListTile(
              title: const Text('New Entry'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushNamed('/new', arguments: app_ctx);
              }
          ),

          const Divider(),

          ListTile(
              title: const Text('View Entries'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/entries', arguments: app_ctx);
              }
          ),

          const Divider(),

          ListTile(
            title: const Text('About'),
            onTap: () => Navigator.of(context).pushNamed('/about', arguments: app_ctx),
          ),

          const Divider(),

          ListTile(
            title: const Text('Log Out'),
            onTap: () => Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/login', (Route _) => false),
          ),
        ],
      ),
    );
  }
}