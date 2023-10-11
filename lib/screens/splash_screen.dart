import 'package:flutter/material.dart';
import 'package:tugas_akhir2/screens/register_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Splash Screen',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Slide 1
              Container(
                color: const Color.fromARGB(255, 39, 169, 238),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/slide1.png',
                      width: 300.0,
                      height: 300.0,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Selamat Datang Teman - teman semua!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Slide 2
              Container(
                color: const Color.fromARGB(255, 39, 169, 238),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/slide2.png',
                      width: 300.0,
                      height: 300.0,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Sebelum Mengenal Lebih Dalam Tentang Aplikasi ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Slide 3
              Container(
                color: Colors.lightBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/slide3.png',
                          width: 300.0,
                          height: 300.0,
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Regristrasi akun dulu yuk!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Indikator Slide
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  width: 15.0,
                  height: 15.0,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.white : Colors.grey,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
