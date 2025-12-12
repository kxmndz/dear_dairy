import 'dart:convert';
import 'dart:io';

import 'package:dear_dairy/Entry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';

import 'DairyEntryCard.dart';

class AppContext {
  late final String username;
  late List<Entry> entries;

  // private internal constructor
  AppContext.internal({required this.username});

  // future handling for async data loading
  static Future<AppContext> create(String username) async {
    final ctx = AppContext.internal(username: username);
    await ctx._loadEntries(); // Wait for file reading to complete
    return ctx;
  }

  List<Entry> getEntries() {
    return entries;
  }

  void push(Entry e) {
    entries.add(e);
    _writeEntriesToFile(username, entries);
  }

  void deleteEntry(Entry toDelete) {
    entries.remove(toDelete);
    _writeEntriesToFile(username, entries);
  }

  void clearEntries() {
    entries = [];
    _writeEntriesToFile(username, entries);
  }

  List<DairyEntryCard> buildCards() {
    return entries.map((e) {
      return DairyEntryCard(entry: e, onDelete: deleteEntry);
    }).toList();
  }

  Future<void> _loadEntries() async {
    entries = await _readEntriesFromFile(username);
  }

  // Helper function for the JSON reviver
  dynamic _reviveEntry(Object? key, Object? value) {
    if (value is Map<String, dynamic> && key is int) {
      // assume json is only created from this app and not modified by anything else
      return Entry.fromJson(value);
    }
    return value;
  }

  // Helper function for JSON toEncodable
  dynamic _toEntryEncodable(Object? nonEncodable) {
    if (nonEncodable is Entry) {
      return nonEncodable.toJson();
    }
    return nonEncodable;
  }

  // Helper method to get storage key for web or filename on mobile/desktop
  String _getStorageKey(String username) {
    return '$username-entries';
  }

  Future<File> _getLocalFile(String username) async {
    // only called when NOT on web
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File(
      '$path/${_getStorageKey(username)}.json',
    );
  }

  Future<List<Entry>> _readEntriesFromFile(String username) async {
    final storageKey = _getStorageKey(username);

    // web
    if (kIsWeb) {
      final jsonStr = html.window.localStorage[storageKey];
      if (jsonStr == null) {
        return [];
      }

      try {
        final jsonObj = jsonDecode(jsonStr, reviver: _reviveEntry);
        return jsonObj.cast<Entry>();
      } catch (e) {
        print('Error decoding entries from LocalStorage: $e');
        return [];
      }

      // mobile/desktop
    } else {
      final file = await _getLocalFile(username);
      if (!await file.exists()) {
        return [];
      }

      try {
        final jsonStr = await file.readAsString();

        final jsonObj = jsonDecode(jsonStr, reviver: _reviveEntry);

        return jsonObj.cast<Entry>();
      } catch (e) {
        print('Error reading/decoding entries file: $e');
        return [];
      }
    }
  }


  Future<void> _writeEntriesToFile(String username, List<Entry> entries) async {
    final storageKey = _getStorageKey(username);

    final jsonStr = jsonEncode(entries, toEncodable: _toEntryEncodable);

    if (kIsWeb) {
      html.window.localStorage[storageKey] = jsonStr;
    } else {
      final file = await _getLocalFile(username);
      await file.writeAsString(jsonStr);
    }
  }
}

class EntryObj extends Object {
  late String text;
  late int timestamp;
}
