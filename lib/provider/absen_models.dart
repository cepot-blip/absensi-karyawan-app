import 'package:flutter/foundation.dart';
import 'package:tugas_akhir2/api/absen_masuk_api.dart';

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

  void updateTraffic(String action) {}

  void tambahAbsensi(Absen absen) {}
}
