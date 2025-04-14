import 'package:flutter/material.dart';
import '../models/farmer_activity.dart';

class ActivityProvider with ChangeNotifier {
  final Map<DateTime, List<FarmerActivity>> _activities = {};

  Map<DateTime, List<FarmerActivity>> get activities => _activities;

  void addActivity(FarmerActivity activity) {
    final key = DateTime(activity.date.year, activity.date.month, activity.date.day);
    if (_activities.containsKey(key)) {
      _activities[key]!.add(activity);
    } else {
      _activities[key] = [activity];
    }
    notifyListeners();
  }

  List<FarmerActivity> getActivitiesForDay(DateTime day) {
    return _activities[DateTime(day.year, day.month, day.day)] ?? [];
  }
}
