import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir2/provider/users_models.dart';
import 'package:tugas_akhir2/screens/home_screen.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(userData.profilePicturePath),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showImagePickerDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Name      :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: userData.fullname,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Email       :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: userData.email,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.work),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Jabatan  :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: userData.jabatan,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.call),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Telepon  :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: userData.telepon,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Foto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery, context);
                  Navigator.pop(context);
                },
                child: const Text("Pilih dari Galeri"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.camera, context);
                  Navigator.pop(context);
                },
                child: const Text("Ambil Foto Baru"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await picker.pickImage(source: source);
    } catch (e) {
      if (kDebugMode) {
        print('Kesalahan pemilih gambar: $e');
      }
    }

    // ignore: use_build_context_synchronously
    final userProvider = context.read<UserProvider>();

    if (pickedFile != null) {
      userProvider.updateProfilePicture(pickedFile.path);

      // ignore: use_build_context_synchronously
      if (context.findRenderObject() != null &&
          // ignore: use_build_context_synchronously
          context.findRenderObject()!.attached) {
        setState(() {});
      }
    }
  }
}
