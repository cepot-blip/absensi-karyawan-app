import 'package:http/http.dart' as http;
import 'dart:convert';

class PengajuanCuti {
  final int id;
  final String jenisCuti;
  final int jumlahCuti;
  final DateTime tanggalRequest;
  final String statusPengajuan;
  final String description;

  PengajuanCuti({
    required this.id,
    required this.jenisCuti,
    required this.jumlahCuti,
    required this.tanggalRequest,
    required this.statusPengajuan,
    required this.description,
  });

  factory PengajuanCuti.fromJson(Map<String, dynamic> json) {
    return PengajuanCuti(
      id: json['id'] as int,
      jenisCuti: json['jenis_cuti'],
      jumlahCuti: json['jumlah_cuti'],
      tanggalRequest: DateTime.parse(json['tanggal_request']),
      statusPengajuan: json['status_pengajuan'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenis_cuti': jenisCuti,
      'jumlah_cuti': jumlahCuti,
      'tanggal_request': tanggalRequest.toIso8601String(),
      'status_pengajuan': statusPengajuan,
      'description': description,
    };
  }
}

class PengajuanCutiApi {
  final String baseUrl = 'http://localhost:9000/api/pengajuan-cuti';

  Future<List<PengajuanCuti>> getPengajuanCutis() async {
    final response = await http.post(Uri.parse('$baseUrl/read'));

    if (response.statusCode == 200) {
      final Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => PengajuanCuti.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load leave requests');
    }
  }

  Future<PengajuanCuti> createPengajuanCuti(PengajuanCuti request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return PengajuanCuti.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create leave request');
    }
  }
}
