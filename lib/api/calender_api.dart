import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarApi {
  final String baseUrl = 'http://localhost:9000/api/note';

  Future<List<Event>> getEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/note/read'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((event) => Event.fromJson(event)).toList();
      } else {
        throw Exception('Failed to get events.');
      }
    } catch (e) {
      return [];
    }
  }

  Future<Event?> createEvent(Event event) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/note/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(event.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Event.fromJson(data);
      } else {
        throw Exception('Failed to create event.');
      }
    } catch (e) {
      return null;
    }
  }
}

class Event {
  final int id;
  final String title;
  final String content;

  Event({required this.id, required this.title, required this.content});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
