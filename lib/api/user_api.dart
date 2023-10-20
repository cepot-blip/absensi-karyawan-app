import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  final String baseUrl = 'http://localhost:9000/api/users';

  Future<Map<String, dynamic>?> registerUser(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to create user.');
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateUser(
      int userId, Map<String, dynamic> updatedUserData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedUserData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(int userId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$userId'));

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
