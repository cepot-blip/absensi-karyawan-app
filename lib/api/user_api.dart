import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterApi {
  final String baseUrl = 'https://7c70-103-175-225-77.ngrok-free.app/api/users';

  Future<bool> registerUser(
    String email,
    String password,
    String fullname,
    String jabatan,
    String telepon,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'fullname': fullname,
          'jabatan': jabatan,
          'telepon': telepon,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

class LoginApi {
  final String baseUrl = 'https://7c70-103-175-225-77.ngrok-free.app/api/users';

  Future<bool> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
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
}
