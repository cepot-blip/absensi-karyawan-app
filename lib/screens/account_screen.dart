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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
