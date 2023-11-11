import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir2/provider/absen_models.dart';

class AbsenMasukScreen extends StatefulWidget {
  const AbsenMasukScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AbsenMasukScreenState createState() => _AbsenMasukScreenState();
}

class _AbsenMasukScreenState extends State<AbsenMasukScreen> {
  String? selectedAction;

  void _selectAction(String action, AbsenModel absenModel) {
    setState(() {
      selectedAction = action;
      absenModel.updateTraffic(action);
    });
  }

  Widget _buildActionButton(String action, AbsenModel absenModel) {
    return TextButton(
      onPressed: () {
        _selectAction(action, absenModel);
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
        title: const Text('Absensi Masuk'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<AbsenModel>(
            builder: (context, absenModel, child) {
              return Column(
                children: [
                  Image.asset(
                    'assets/images/absen.png',
                    width: 300.0,
                    height: 220.0,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton('Hadir', absenModel),
                      const SizedBox(width: 24.0),
                      _buildActionButton('Izin', absenModel),
                      const SizedBox(width: 24.0),
                      _buildActionButton('Sakit', absenModel),
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
                              content: Text(
                                'Anda berhasil absen sebagai $selectedAction.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (selectedAction == 'Hadir') {
                                      Provider.of<AbsenModel>(context,
                                              listen: false)
                                          .tambahHadir();
                                    } else if (selectedAction == 'Sakit') {
                                      Provider.of<AbsenModel>(context,
                                              listen: false)
                                          .tambahSakit();
                                    } else if (selectedAction == 'Izin') {
                                      Provider.of<AbsenModel>(context,
                                              listen: false)
                                          .tambahIzin();
                                    }
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
                      'Absen Masuk',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
