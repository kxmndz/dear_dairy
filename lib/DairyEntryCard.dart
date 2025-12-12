import 'package:dear_dairy/Entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DairyEntryCard extends StatefulWidget {
  final Entry entry;
  final Function(Entry) onDelete;

  const DairyEntryCard({super.key, required this.entry, required this.onDelete});

  @override
  State<DairyEntryCard> createState() => _DairyEntryCardState();
}

class _DairyEntryCardState extends State<DairyEntryCard> {
  bool _isExpanded = false;


  void _deleteEntry() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this entry?'),
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
                widget.onDelete(widget.entry);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the text content based on the expanded state
    final String fullText = widget.entry.text;
    final bool requiresExpansion = fullText.length > 200;

    // Text to display when collapsed (up to 200 characters)
    final String collapsedText = requiresExpansion
        ? fullText.substring(0, 200) + '...'
        : fullText;

    return Card(
      child: InkWell(
        onTap: () {
          // Toggle expanded state on tap
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header row
              Row(
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(widget.entry.timestamp),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                    onPressed: _deleteEntry, // Calls the local handler
                    tooltip: 'Delete Entry',
                  ),
                ],
              ),

              // spacer
              const SizedBox(height: 8),

              if (_isExpanded)
              // expanded view with scrollable text
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    child: Text(fullText),
                  ),
                )
              else
              // collapsed view, with short text
                Text(collapsedText),

              // instruction text
              if (requiresExpansion)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _isExpanded ? 'Tap to collapse ▲' : 'Tap to read more ▼',
                    style: const TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}