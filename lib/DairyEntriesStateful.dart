import 'package:flutter/material.dart';
import 'package:dear_dairy/AppContext.dart';

import 'DairyDrawerStateful.dart';

class DairyEntriesPage extends StatefulWidget {
  const DairyEntriesPage({super.key});

  @override
  State<DairyEntriesPage> createState() => _DairyEntriesPageState();
}

class _DairyEntriesPageState extends State<DairyEntriesPage> {
  late Future<AppContext> _contextFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final passedArgument = ModalRoute.of(context)!.settings.arguments;

    String username;
    if (passedArgument is AppContext) {
      username = passedArgument.username;
    } else {
      username = 'guest';
    }

    _contextFuture = AppContext.create(username);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppContext>(
      future: _contextFuture,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still loading
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading entries...'),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // An error occurred during file loading/decoding
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          // Data is successfully loaded
          final AppContext ctx = snapshot.data!;

          return Scaffold(
            // default bar
            // appBar: bar,
            drawer: DairyDrawer(app_ctx: ctx),
            appBar: AppBar(title: Text('${ctx.username}\'s Entries')),
            body: Center(
              child: ListView(
                children: [
                  ...ctx.buildCards(),
                  if (ctx.getEntries().isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          'No entries found. Add your first dream!',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new', arguments: ctx);
              },
              child: const Icon(Icons.add),
            ),
          );
        }

        // default case, should never be reached if everything loads correctly
        return const Center(child: Text('Unknown State'));
      },
    );
  }
}