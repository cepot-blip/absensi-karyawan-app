import 'package:flutter/material.dart';
import 'package:tugas_akhir2/widget/CustomButton.dart';
import 'package:tugas_akhir2/widget/Trafic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Homepage',
      home: HomePage(
        email: '',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CalendarScreen(),
    const ReportScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang'),
        actions: const [
          Row(
            children: [
              Text(
                'John Doe',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absen Masuk'),
      ),
      body: const Center(
        child: Text('Halaman Absen Masuk'),
      ),
    );
  }
}

class AbsenKeluarScreen extends StatelessWidget {
  const AbsenKeluarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absen Keluar'),
      ),
      body: const Center(
        child: Text('Halaman Absen Keluar'),
      ),
    );
  }
}

class PengajuanCutiScreen extends StatelessWidget {
  const PengajuanCutiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Cuti'),
      ),
      body: const Center(
        child: Text('Halaman Pengajuan Cuti'),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Halaman Calendar'),
      ),
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Halaman Report'),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Halaman Akun'),
      ),
    );
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
