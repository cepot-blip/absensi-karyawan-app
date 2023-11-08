import 'package:flutter/material.dart';

class Event {
  final String title;
  final String content;

  Event(this.title, this.content);
}

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    final contentParts = event.content.split('\n');

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          // Handle tap event if needed
        },
        title: RichText(
          text: TextSpan(
            style: const TextStyle(fontWeight: FontWeight.normal),
            children: [
              TextSpan(
                text: contentParts[0],
                style: const TextStyle(color: Colors.black),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: contentParts[1],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
