import 'dart:io';

import 'package:flutter/cupertino.dart';

class PlatformController extends ChangeNotifier {
  bool isAndroid = false;
  File? image;

  void changePlatform({required bool val}) {
    isAndroid = val;
    notifyListeners();
  }

  void addImage({required File img}) {
    image = img;
    notifyListeners();
  }
}
