import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir2/provider/absen_models.dart';

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
                    _submitAbsen(context);
                  } else {
                    _showErrorDialog(
                      context,
                      'Silakan pilih opsi absen terlebih dahulu.',
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

  void _submitAbsen(BuildContext context) {
    if (selectedAction != null) {
      final absenModel = Provider.of<AbsenModel>(context, listen: false);
      absenModel.updateData(selectedAction!, currentTime, '');
      absenModel.updateJamPulang(currentTime);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Report(
            selectedAction: selectedAction!,
            currentTime: currentTime,
          ),
        ),
      );
    } else {
      _showErrorDialog(
        context,
        'Silakan pilih opsi absen terlebih dahulu.',
      );
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Oopss !!'),
          content: Text(message),
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
}

class Report extends StatelessWidget {
  final String currentTime;
  final String selectedAction;

  const Report({
    Key? key,
    required this.currentTime,
    required this.selectedAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, d MMMM y').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Absensi"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 370,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Tampilan Laporan Absen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 370,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text('Jenis Absensi   : $selectedAction'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.more_time_outlined),
                      const SizedBox(width: 10),
                      Text('Jam Masuk       : $currentTime'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.av_timer_outlined),
                      SizedBox(width: 10),
                      Text('Jam Pulang       : -'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
