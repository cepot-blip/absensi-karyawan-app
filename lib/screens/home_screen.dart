import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir2/provider/users_models.dart';
import 'package:tugas_akhir2/screens/absen_keluar_screen.dart';
import 'package:tugas_akhir2/screens/absen_masuk_screen.dart';
import 'package:tugas_akhir2/screens/account_screen.dart';
import 'package:tugas_akhir2/screens/login_screen.dart';
import 'package:tugas_akhir2/screens/pengajuan_cuti_screen.dart';
import 'package:tugas_akhir2/screens/report_screen.dart';
import 'package:tugas_akhir2/widget/CustomButton.dart';
import 'package:tugas_akhir2/widget/Trafic.dart';
import 'package:tugas_akhir2/widget/MyBottomNavigationBar.dart';
import 'package:tugas_akhir2/screens/calender_screen.dart';
import 'package:tugas_akhir2/provider/absen_models.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required String email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Homepage',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late AppBar homeAppBar;

  final List<Widget> _pages = const [
    HomeScreen(),
    CalenderScreen(),
    ReportScreen(
      selectedAction: '',
      currentTime: '',
    ),
    Account(),
  ];

  @override
  void initState() {
    super.initState();
    homeAppBar = AppBar(
      title: const Text('Selamat Datang'),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: _currentIndex == 0 ? homeAppBar : null,
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
        drawer: Drawer(
          child: Consumer<UserProvider>(builder: (context, userProvider, _) {
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userProvider.fullname),
                  accountEmail: Text(userProvider.email),
                  currentAccountPicture: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: userData.profilePicturePath.isNotEmpty
                            ? FileImage(File(userData.profilePicturePath))
                            : AssetImage('assets/images/defaultpp.jpeg')
                                as ImageProvider,
                      ),
                      // Add other widgets/components as needed on top of the CircleAvatar
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Account()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Calendar'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalenderScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.insert_chart),
                  title: const Text('Report'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportScreen(
                                currentTime: '',
                                selectedAction: '',
                              )),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Log Out'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                ),
              ],
            );
          }),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void navigateToPage(BuildContext context, String page) {
    if (page == 'Absen Masuk') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AbsenMasukScreen(),
      ));
    } else if (page == 'Absen Pulang') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AbsenKeluar(),
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
    } else if (page == 'Report') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ReportScreen(
          selectedAction: '',
          currentTime: '',
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<AbsenModel>(
                builder: (context, absenModel, child) {
                  return Trafict(
                    iconData: Icons.check,
                    count: absenModel.hadirCount,
                    label: 'Hadir',
                  );
                },
              ),
              Consumer<AbsenModel>(
                builder: (context, absenModel, child) {
                  return Trafict(
                    iconData: Icons.local_hospital,
                    count: absenModel.sakitCount,
                    label: 'Sakit',
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<AbsenModel>(
                builder: (context, absenModel, child) {
                  return Trafict(
                    iconData: Icons.error,
                    count: absenModel.izinCount,
                    label: 'Izin',
                  );
                },
              ),
              // Consumer<AbsenModel>(
              //   builder: (context, absenModel, child) {
              //     return Trafict(
              //       iconData: Icons.beach_access,
              //       count: absenModel.cutiCount,
              //       label: 'Cuti',
              //     );
              //   },
              // ),
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
                buttonColor: Colors.green,
                iconColor: Colors.white,
                onPressed: () {
                  navigateToPage(context, 'Absen Masuk');
                },
              ),
              CustomButton(
                iconData: Icons.logout,
                label: 'Absen Pulang',
                buttonColor: Colors.red,
                iconColor: Colors.white,
                onPressed: () {
                  navigateToPage(context, 'Absen Pulang');
                },
              ),
              CustomButton(
                iconData: Icons.send,
                label: 'Pengajuan Cuti',
                buttonColor: Colors.blue,
                iconColor: Colors.white,
                onPressed: () {
                  navigateToPage(context, 'Pengajuan Cuti');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
