import 'package:flutter/material.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PengajuanCutiState createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final TextEditingController _tanggalRequestController =
      TextEditingController();
  final TextEditingController _jumlahCutiController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  String? _selectedJenisCuti;
  String? _selectedStatusPengajuan;
  List<String> jenisCutiOptions = [
    'Cuti Tahunan',
    'Cuti Sakit',
    'Cuti Hamil',
  ];

  List<String> statusPengajuanOptions = [
    'Menunggu',
    'Disetujui',
    'Ditolak',
  ];

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success!'),
          content: const Text('Pengajuan cuti Anda telah berhasil diajukan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _submitPengajuanCuti() {
    if (_tanggalRequestController.text.isEmpty ||
        _jumlahCutiController.text.isEmpty ||
        _keteranganController.text.isEmpty ||
        _selectedJenisCuti == null ||
        _selectedStatusPengajuan == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Oopss !!'),
            content: const Text('Semua field harus diisi!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      _showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Cuti'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 200.0,
                height: 120.0,
                child: Image.asset(
                  'assets/images/cuti.png',
                ),
              ),
              const Text(
                'Pengajuan Cuti',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedJenisCuti,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedJenisCuti = newValue;
                        });
                      },
                      items: jenisCutiOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Jenis Cuti',
                        hintText: 'Pilih jenis cuti',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _tanggalRequestController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Request',
                        hintText: 'Pilih tanggal',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _jumlahCutiController,
                      decoration: InputDecoration(
                        labelText: 'Jumlah Cuti',
                        hintText: 'Masukkan jumlah cuti',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    DropdownButtonFormField<String>(
                      value: _selectedStatusPengajuan,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatusPengajuan = newValue;
                        });
                      },
                      items: statusPengajuanOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Status Pengajuan',
                        hintText: 'Pilih status pengajuan cuti',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _keteranganController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Tambah Keterangan',
                        labelStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitPengajuanCuti,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Pengajuan Cuti',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
