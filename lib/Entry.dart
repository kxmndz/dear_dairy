import 'dart:convert';

class Entry {
  String text = '';
  DateTime timestamp = DateTime.now();

  Entry({required this.text, required this.timestamp});

  static Entry fromJson(Map<String, dynamic> json) {
    return Entry(
      text: json['text'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  static Entry from({required String text, required int timestamp}) {
    return Entry(text: text, timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  @override
  String toString() {
    return '{text:"${jsonEncode(text)}",timestamp:${timestamp.millisecondsSinceEpoch}}';
  }
}