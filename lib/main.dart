import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir2/provider/absen_models.dart';
import 'package:tugas_akhir2/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AbsenModel>(create: (contex) => AbsenModel()),
      ],
      child: const MyApp(email: ''),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String email});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Absensi Karyawan',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
