import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _selectedFile;

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedFile = null;
    });
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
                      items: ['Cuti Tahunan', 'Cuti Sakit', 'Cuti Hamil']
                          .map((String value) {
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
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          OutlinedButton(
                            onPressed: _pickImage,
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              side: const BorderSide(color: Colors.blue),
                            ),
                            child: const Text(
                              'Unggah Foto',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          if (_selectedFile != null) ...[
                            const SizedBox(width: 8.0),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: _removeImage,
                              color: Colors.red,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (_selectedFile != null)
                      Text('File: ${_selectedFile!.path}'),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _keteranganController,
                      maxLines: 3,
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
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 130.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        side: const BorderSide(color: Colors.blue),
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

  void _submitPengajuanCuti() {
    if (_tanggalRequestController.text.isEmpty ||
        _jumlahCutiController.text.isEmpty ||
        _keteranganController.text.isEmpty ||
        _selectedJenisCuti == null ||
        _selectedFile == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Oopss !!'),
            content: const Text('Semua field harus diisi, termasuk foto!'),
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
}
