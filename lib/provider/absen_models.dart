import 'package:flutter/foundation.dart';

class AbsenModel extends ChangeNotifier {
  String? selectedAction;
  String? currentTime;

  void updateData(String action, String time, String note) {
    selectedAction = action;
    currentTime = time;
    notifyListeners();
  }

  int hadirCount = 0;
  int sakitCount = 0;
  int izinCount = 0;

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
