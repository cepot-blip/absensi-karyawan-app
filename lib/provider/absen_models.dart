import 'package:flutter/foundation.dart';

class AbsenModel extends ChangeNotifier {
  int hadirCount = 0;
  int sakitCount = 0;
  int izinCount = 0;
  int cutiCount = 0;

  void tambahHadir() {
    hadirCount++;
    notifyListeners();
  }

  void tambahSakit() {
    sakitCount++;
    notifyListeners();
  }

  void tambahIzin() {
    izinCount++;
    notifyListeners();
  }

  void tambahCuti() {
    cutiCount++;
    notifyListeners();
  }

  void updateTraffic(String action) {
    if (action == 'Hadir') {
      tambahHadir();
    } else if (action == 'Sakit') {
      tambahSakit();
    } else if (action == 'Izin') {
      tambahIzin();
    }
  }
}
