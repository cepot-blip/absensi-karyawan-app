import 'package:flutter/material.dart';
import 'package:tugas_akhir2/screens/absen_keluar_screen.dart';
import 'package:tugas_akhir2/screens/absen_masuk_screen.dart';
import 'package:tugas_akhir2/screens/pengajuan_cuti_screen.dart';
import 'package:tugas_akhir2/screens/report_screen.dart';
import 'package:tugas_akhir2/widget/CustomButton.dart';
import 'package:tugas_akhir2/widget/Trafic.dart';
import 'package:tugas_akhir2/screens/calender_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Homepage',
      home: HomePage(currentIndex: 0),
    );
  }
}

class HomePage extends StatefulWidget {
  final int currentIndex;

  const HomePage({Key? key, required this.currentIndex}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(email: ''),
    const CalendarScreen(),
    const ReportScreen(),
    const AccountScreen(),
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
  final String email;

  const HomeScreen({super.key, required this.email});

  void navigateToPage(BuildContext context, String page) {
    if (page == 'Absen Masuk') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AbsenMasukScreen(),
      ));
    } else if (page == 'Absen Keluar') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AbsenKeluarScreen(),
      ));
    } else if (page == 'Pengajuan Cuti') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PengajuanCutiScreen(),
      ));
    } else if (page == 'Kalender') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CalendarScreen(),
      ));
    } else if (page == 'Akun') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AccountScreen(),
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
                      builder: (context) => const AbsenMasukScreen(),
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
                      builder: (context) => const AbsenKeluarScreen(),
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
                      builder: (context) => const PengajuanCutiScreen(),
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

class AbsenMasukScreen extends StatelessWidget {
  const AbsenMasukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AbsensiMasukScreen());
  }
}

class AbsenKeluarScreen extends StatelessWidget {
  const AbsenKeluarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AbsensiKeluarScreen(),
    );
  }
}

class PengajuanCutiScreen extends StatelessWidget {
  const PengajuanCutiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PengajuanCuti(),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CalenderScreen());
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ReportsScreen());
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AccountScreen());
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[600],
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Akun',
        ),
      ],
    );
  }
}
