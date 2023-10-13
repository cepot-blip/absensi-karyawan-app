import 'package:flutter/material.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 370,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Position',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                ),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Country'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk aksi di halaman akun jika diperlukan
                  },
                  child: const Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk logout jika diperlukan
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
