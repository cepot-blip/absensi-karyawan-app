import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenKeluar extends StatefulWidget {
  const AbsenKeluar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AbsenKeluarState createState() => _AbsenKeluarState();
}

class _AbsenKeluarState extends State<AbsenKeluar> {
  String? selectedAction;
  late String currentTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    currentTime = DateFormat.Hms().format(DateTime.now());
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      currentTime = DateFormat.Hms().format(DateTime.now());
    });
  }

  void _selectAction(String action) {
    setState(() {
      selectedAction = action;
    });
  }

  Widget _buildActionButton(String action) {
    return TextButton(
      onPressed: () {
        _selectAction(action);
      },
      style: TextButton.styleFrom(
        backgroundColor:
            selectedAction == action ? Colors.blue : const Color(0xFFDFDFDF),
        padding: const EdgeInsets.symmetric(horizontal: 37.0),
      ),
      child: Text(
        action,
        style: TextStyle(
          color: selectedAction == action ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi Pulang'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/absen2.png',
                width: 300.0,
                height: 220.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Waktu Sekarang: $currentTime',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton('Hadir'),
                  const SizedBox(width: 24.0),
                  _buildActionButton('Izin'),
                  const SizedBox(width: 24.0),
                  _buildActionButton('Sakit'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Tambah keterangan jika sakit atau izin.',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  if (selectedAction != null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Berhasil Absen'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Anda berhasil absen sebagai $selectedAction.',
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Pada Tanggal dan Waktu: ${DateFormat('EEEE, d MMMM y H:m:s').format(DateTime.now())}',
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (selectedAction == 'Hadir') {
                                } else if (selectedAction == 'Sakit') {
                                } else if (selectedAction == 'Izin') {}
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Oopss !!'),
                          content: const Text(
                              'Silakan pilih opsi absen terlebih dahulu.'),
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
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 138.0),
                ),
                child: const Text(
                  'Absen Pulang',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
