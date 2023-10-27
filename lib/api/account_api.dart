import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountApi {
  final String baseUrl = 'http://localhost:9000/api/profile';

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/read'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Gagal mendapatkan informasi pengguna.');
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUserInfo(Map<String, dynamic> updatedUserData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update'),
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
}
