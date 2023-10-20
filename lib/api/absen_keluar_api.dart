import 'dart:convert';
import 'package:http/http.dart' as http;

class AbsenKeluar {
  final int id;
  final DateTime absen;
  final int userId;
  final String description;

  AbsenKeluar({
    required this.id,
    required this.absen,
    required this.userId,
    required this.description,
  });

  factory AbsenKeluar.fromJson(Map<String, dynamic> json) {
    return AbsenKeluar(
      id: json['id'] as int,
      absen: DateTime.parse(json['absen']),
      userId: json['user_id'] as int,
      description: json['description'],
    );
  }
}

class AbsenApi {
  final String baseUrl = 'http://localhost:9000/api/absen-keluar';

  Future<List<AbsenKeluar>> getAbsenList() async {
    final response = await http.post(Uri.parse('$baseUrl/read'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => AbsenKeluar.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load absen list');
    }
  }

  Future<AbsenKeluar> createAbsen(AbsenKeluar absen) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(absen),
    );

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return AbsenKeluar.fromJson(data);
    } else {
      throw Exception('Failed to create absen');
    }
  }

  Future<void> updateAbsen(int id, AbsenKeluar absen) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(absen),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update absen');
    }
  }

  Future<void> deleteAbsen(int id, AbsenKeluar absen) async {
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
