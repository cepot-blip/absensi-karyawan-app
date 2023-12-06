import 'dart:convert';
import 'package:http/http.dart' as http;

class Absen {
  final int id;
  final DateTime absen;
  final int userId;
  final String description;

  Absen({
    required this.id,
    required this.absen,
    required this.userId,
    required this.description,
  });

  factory Absen.fromJson(Map<String, dynamic> json) {
    return Absen(
      id: json['id'],
      absen: DateTime.parse(json['absen']),
      userId: json['user_id'],
      description: json['description'],
    );
  }
}

class AbsenApi {
  final String baseUrl =
      'https://7bca-182-0-212-135.ngrok-free.app/api/absen-masuk';

  Future<Absen> createAbsen(Absen absen) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(absen),
    );

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return Absen.fromJson(data);
    } else {
      throw Exception('Failed to create absen');
    }
  }
}
