import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _profilePicturePath = 'assets/images/defaultpp.jpeg';

  String get profilePicturePath => _profilePicturePath;

  void updateProfilePicture(String imagePath) {
    _profilePicturePath = imagePath;
    notifyListeners();
  }

  String email = '';
  String fullname = '';
  String jabatan = '';
  String telepon = '';

  void setUserData({
    required String email,
    required String fullname,
    required String jabatan,
    required String telepon,
  }) {
    this.email = email;
    this.fullname = fullname;
    this.jabatan = jabatan;
    this.telepon = telepon;
    notifyListeners();
  }
}
