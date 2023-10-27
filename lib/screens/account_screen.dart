import 'package:flutter/material.dart';
import '../api/account_api.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<Account> {
  final AccountApi _accountApi = AccountApi();

  String nama = '';
  String jabatan = '';
  String telepon = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    final userInfo = await _accountApi.getUserInfo();
    if (userInfo != null) {
      setState(() {
        nama = userInfo['fullname'];
        jabatan = userInfo['jabatan'];
        telepon = userInfo['telepon'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/pzn.png'),
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
                              text: 'Nama :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: nama,
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
                              text: 'Jabatan :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: jabatan,
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
                      leading: const Icon(Icons.location_on),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Telepon :  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            TextSpan(
                              text: telepon,
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
}
