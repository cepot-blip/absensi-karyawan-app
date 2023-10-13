import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 370,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Position',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 24),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Country'),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk aksi di halaman akun jika diperlukan
                  },
                  child: Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk logout jika diperlukan
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
