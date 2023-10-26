import 'package:flutter/material.dart';
import 'package:tugas_akhir2/screens/absen_keluar_screen.dart';
import 'package:tugas_akhir2/screens/absen_masuk_screen.dart';
import 'package:tugas_akhir2/screens/account_screen.dart';
import 'package:tugas_akhir2/screens/pengajuan_cuti_screen.dart';
import 'package:tugas_akhir2/screens/report_screen.dart';
import 'package:tugas_akhir2/widget/CustomButton.dart';
import 'package:tugas_akhir2/widget/Trafic.dart';
import 'package:tugas_akhir2/widget/MyBottomNavigationBar.dart';
import 'package:tugas_akhir2/screens/calender_screen.dart';

void main() => runApp(const MyApp(
      email: '',
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String email});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Homepage', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  final int currentIndex = 0;

  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CalenderScreen(),
    const Report(),
    const Account(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang'),
        actions: const [
          Row(
            children: [
              Text(
                'Ipul',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              Icon(Icons.notifications),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToPage(BuildContext context, String page) {
    if (page == 'Absen Masuk') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Absenmasuk(),
      ));
    } else if (page == 'Absen Keluar') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Absenkeluar(),
      ));
    } else if (page == 'Pengajuan Cuti') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PengajuanCuti(),
      ));
    } else if (page == 'Kalender') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CalenderScreen(),
      ));
    } else if (page == 'Akun') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Account(),
      ));
    } else if (page == 'Akun') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Report(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Trafict(iconData: Icons.check, count: 2, label: 'Hadir'),
              Trafict(
                iconData: Icons.local_hospital,
                count: 5,
                label: 'Sakit',
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Trafict(
                iconData: Icons.error,
                count: 1,
                label: 'Izin',
              ),
              Trafict(iconData: Icons.beach_access, count: 4, label: 'Cuti'),
            ],
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Menu Absensi',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20.0),
          Column(
            children: [
              CustomButton(
                iconData: Icons.login,
                label: 'Absen Masuk',
                buttonColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Absenmasuk(),
                    ),
                  );
                },
              ),
              CustomButton(
                iconData: Icons.logout,
                label: 'Absen Keluar',
                buttonColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Absenkeluar(),
                    ),
                  );
                },
              ),
              CustomButton(
                iconData: Icons.send,
                label: 'Pengajuan Cuti',
                buttonColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PengajuanCuti(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
