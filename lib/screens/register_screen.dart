// ignore_for_file: use_build_context_synchronously
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas_akhir2/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isRegistered = false;

  // Future<void> registerUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     final response = await http.post(
  //       Uri.parse('http://localhost:9000/api/users/create'),
  //       body: {
  //         'email': email,
  //         'password': password,
  //       },
  //     );

  //     if (response.statusCode == 201) {
  //       final responseData = json.decode(response.body);
  //       final message = responseData['message'];

  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text('Registrasi Berhasil'),
  //             content: Text(message),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => const LoginScreen(),
  //                     ),
  //                   );
  //                 },
  //                 child: const Text('Tutup'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text('Registrasi Gagal'),
  //             content: const Text('Registrasi gagal. Silakan coba lagi.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Tutup'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

  void register() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isRegistered = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    register();
                    if (isRegistered) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Registrasi Berhasil'),
                            content:
                                const Text('Anda telah berhasil terdaftar.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Tambahkan ini untuk menavigasi ke layar login.
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Tutup'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sudah punya akun? Login di sini',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
