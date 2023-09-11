import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateTimeController extends ChangeNotifier {
  DateTime? dateTime = DateTime.now();
  TimeOfDay? timeOfDay = TimeOfDay.now();

  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  SharedPreferences preferences;

  DateTimeController({required this.preferences});

  String _date = "date";
  String _time = "time";

  List<String> dateList = [];
  List<String> timeList = [];

  dateChanged({required DateTime date}) {
    dateTime = date;
    dateController.text =
        "${dateTime!.day}/${dateTime!.month}/${dateTime!.year}";
    notifyListeners();
  }

  timeChanged({required TimeOfDay time}) {
    timeOfDay = time;
    timeController.text = "${timeOfDay!.hour}:${timeOfDay!.minute}";
    notifyListeners();
  }
}
