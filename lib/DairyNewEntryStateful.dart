import 'package:dear_dairy/AppContext.dart';
import 'package:dear_dairy/common_appbar.dart' show bar;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text_ultra/speech_to_text_ultra.dart';

import 'Entry.dart';
import 'common_drawer.dart' show makeDrawer;

class DairyNewEntryPage extends StatefulWidget {
  const DairyNewEntryPage({super.key});

  @override
  State<DairyNewEntryPage> createState() => _DairyNewEntryPageState();
}

class _DairyNewEntryPageState extends State<DairyNewEntryPage> {
  // fixes
  final TextEditingController _dreamController = TextEditingController();
  final FocusNode _dreamFocusNode = FocusNode();
  bool mIsListening = false;
  String mEntireResponse = '';
  String mLiveResponse = '';
  String recordedDreamText = '';

  @override
  void dispose() {
    _dreamController.dispose();
    _dreamFocusNode.dispose();
    super.dispose();
  }

  void _handleDream(BuildContext context, AppContext app_ctx) {

    recordedDreamText += mLiveResponse;


    app_ctx.push(Entry(text: recordedDreamText, timestamp: DateTime.now()));

    _dreamController.clear();
    _dreamFocusNode.unfocus();

    Navigator.of(context).pushNamed('/entries', arguments: app_ctx);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Entry saved: ${recordedDreamText.length < 30 ? recordedDreamText : '${recordedDreamText.substring(0, 30)}...'}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppContext app_ctx =
        ModalRoute.of(context)!.settings.arguments as AppContext;
    return Scaffold(
      appBar: bar,
      drawer: makeDrawer(context),
      floatingActionButton: FloatingActionButton(
        child: SpeechToTextUltra(
          ultraCallback: (String liveText, String finalText, bool isListening) {
            setState(() {
              mLiveResponse = liveText;
              mEntireResponse = finalText;
              mIsListening = isListening;
            });

          },
        ),
        onPressed: () => {},
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              "Today's date: ${DateFormat.yMMMMd().format(DateTime.now())}",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(height: 32),

              TextField(
                controller: _dreamController,
                focusNode: _dreamFocusNode,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  hintText: 'Type content here...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),

            Text('...or press the microphone button and dictate:'),
            mIsListening
                ? Text('$mEntireResponse $mLiveResponse')
                : Text(mLiveResponse),

            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: () => _handleDream(context, app_ctx),
              child: const Text('Add Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
