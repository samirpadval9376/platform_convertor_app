import 'package:flutter/cupertino.dart';

class ProfileController extends ChangeNotifier {
  bool isActive = false;

  void changeProfile({required bool val}) {
    isActive = val;
    notifyListeners();
  }
}
