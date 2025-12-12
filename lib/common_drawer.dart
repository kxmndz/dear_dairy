import 'package:flutter/material.dart';

import 'AppContext.dart';

Drawer makeDrawer(BuildContext context) {
  final AppContext app_ctx = ModalRoute.of(context)!.settings.arguments as AppContext;
  final String username = app_ctx.username;

  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: ListTile(
            title: Text('Dear Dairy'),
            subtitle: Text('Logged in as $username'),
          ),
        ),

        ListTile(
          title: Text('New Entry'),
          onTap: () => Navigator.of(context).pushNamed('/new', arguments: app_ctx),
        ),

        Divider(),

        ListTile(
          title: Text('View Entries'),
          onTap: () => Navigator.of(context).pushNamed('/entries', arguments: app_ctx),
        ),

        Divider(),

        ListTile(
          title: Text('About'),
          onTap: () => Navigator.of(context).pushNamed('/about', arguments: app_ctx),
        ),

        Divider(),

        ListTile(
          title: Text('Log Out'),
          onTap: () => Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (Route _) => false),
        ),
      ],
    ),
  );
}
