import 'package:flutter/cupertino.dart';

class PlatformController extends ChangeNotifier {
  bool isAndroid = false;

  void changePlatform({required bool val}) {
    isAndroid = val;
    notifyListeners();
  }
}
