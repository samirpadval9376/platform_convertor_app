import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime? dateTime = DateTime.now();
  TimeOfDay? timeOfDay = TimeOfDay.now();

  dateChanged({required DateTime date}) {
    dateTime = date;
    notifyListeners();
  }

  timeChanged({required TimeOfDay time}) {
    timeOfDay = time;
    notifyListeners();
  }
}
