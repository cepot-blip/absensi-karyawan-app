import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir2/api/user_api.dart';
import 'package:tugas_akhir2/provider/users_models.dart';
import 'package:tugas_akhir2/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fullname = '';
  String jabatan = '';
  String telepon = '';

  bool isRegistered = false;
  bool _isPasswordHidden = true;

  Future<bool> register() async {
    if (_formKey.currentState!.validate()) {
      final registerApi = RegisterApi();
      final registeredUser = await registerApi.registerUser(
        email,
        password,
        fullname,
        jabatan,
        telepon,
      );

      if (registeredUser) {
        // ignore: use_build_context_synchronously
        context.read<UserProvider>().setUserData(
              email: email,
              fullname: fullname,
              jabatan: jabatan,
              telepon: telepon,
            );

        setState(() {
          isRegistered = true;
        });
        return true;
      } else {
        setState(() {});
        return false;
      }
    }
    return false;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  final RegExp _emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$',
  );

  final RegExp _phoneRegex = RegExp(
    r'^[0-9]+$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Register akun',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          fullname = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    // Jabatan Dropdown
                    _buildJabatanDropdown(),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Telepon',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nomor telepon tidak boleh kosong';
                        } else if (!_phoneRegex.hasMatch(value)) {
                          return 'Nomor telepon hanya boleh mengandung angka';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          telepon = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email tidak boleh kosong';
                        } else if (!_emailRegex.hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: _isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password tidak boleh kosong';
                        } else if (!_passwordRegex.hasMatch(value)) {
                          return 'Password harus mengandung huruf kapital, angka, dan spesial karakter';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await register();
                        if (result) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Successfully Register account!'),
                                content: const Text(
                                  'You have successfully registered.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Failed Register'),
                                content: const Text(
                                  'Failed Register Account!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text('Register'),
                        ),
                      ),
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
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
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
        ),
      ),
    );
  }

  FormField<String> _buildJabatanDropdown() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Jabatan',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          isEmpty: jabatan.isEmpty,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: jabatan.isNotEmpty ? jabatan : null,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  jabatan = newValue!;
                  state.didChange(newValue);
                });
              },
              items: <String>[
                'Pilih Jabatan', // Nilai default
                'Pegawai',
                'Manajer',
                'Direktur',
                'Supervisor',
                'Lainnya'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty || value == 'Pilih Jabatan') {
          return 'Pilih jabatan';
        }
        return null;
      },
    );
  }
}
