import 'package:flutter/material.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PengajuanCutiState createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final TextEditingController _jenisCutiController = TextEditingController();
  final TextEditingController _tanggalRequestController =
      TextEditingController();
  final TextEditingController _jumlahCutiController = TextEditingController();
  final TextEditingController _statusPengajuanController =
      TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

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
    if (_jenisCutiController.text.isEmpty ||
        _tanggalRequestController.text.isEmpty ||
        _jumlahCutiController.text.isEmpty ||
        _statusPengajuanController.text.isEmpty) {
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
                width: 500.0,
                height: 250.0,
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _jenisCutiController,
                            decoration: InputDecoration(
                              labelText: 'Jenis Cuti',
                              hintText: 'Masukkan jenis cuti',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14.0),
                        Expanded(
                          child: TextField(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
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
                        ),
                        const SizedBox(width: 14.0),
                        Expanded(
                          child: TextField(
                            controller: _statusPengajuanController,
                            decoration: InputDecoration(
                              labelText: 'Status Pengajuan',
                              hintText: 'Status pengajuan cuti',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: TextField(
                        controller: _keteranganController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Tambah Keterangan',
                          labelStyle: TextStyle(fontSize: 12.0),
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitPengajuanCuti,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 138.0),
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
