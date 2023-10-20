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
  final String baseUrl = 'http://localhost:9000/api/absen-masuk';

  Future<List<Absen>> getAbsenList() async {
    final response = await http.post(Uri.parse('$baseUrl/read'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Absen.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load absen list');
    }
  }

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

  Future<void> updateAbsen(int id, Absen absen) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(absen),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update absen');
    }
  }

  Future<void> deleteAbsen(int id, Absen absen) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(absen),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete absen');
    }
  }
}
