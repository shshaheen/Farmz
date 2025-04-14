import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:farmz/Views/Screens/Farmer/widget/add_event_modal.dart';

class FarmTasks extends StatefulWidget {
  @override
  _FarmTasksState createState() => _FarmTasksState();
}

class _FarmTasksState extends State<FarmTasks> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  /// Loads events from SharedPreferences
  Future<void> _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEvents = prefs.getString('events');
    if (savedEvents != null) {
      Map<String, dynamic> decodedMap = jsonDecode(savedEvents);
      Map<DateTime, List<String>> loadedEvents = {};
      decodedMap.forEach((key, value) {
        loadedEvents[DateTime.parse(key)] = List<String>.from(value);
      });
      setState(() {
        _events = loadedEvents;
      });
    }
  }

  /// Saves all events to SharedPreferences
  Future<void> _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<String>> jsonMap = {};
    _events.forEach((key, value) {
      jsonMap[key.toIso8601String()] = value;
    });
    await prefs.setString('events', jsonEncode(jsonMap));
  }

  /// Adds a new event and saves it
  void _addEvent(String title, String description) async {
  final dateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
  final eventString = "$title: $description";

  if (_events[dateKey] == null) {
    _events[dateKey] = [];
  }
  _events[dateKey]!.add(eventString);

  await _saveEvents();
  setState(() {});
}


  /// Loads events for the TableCalendar
  List<String> _getEventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _events[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Farmer Calendar")),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            eventLoader: _getEventsForDay,
            calendarFormat: CalendarFormat.month,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay).map((event) {
                return ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.green),
                  title: Text(event),
                  subtitle: Text("All-day"),
                );
              }).toList(),
            ),
          ),
        ],
      ),
     floatingActionButton: FloatingActionButton(
  onPressed: () => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => AddEventModal(
      selectedDate: _selectedDay,
      onSave: (title, description) {
        _addEvent(title, description); // Make sure this method exists
      },
    ),
  ),
  child: Icon(Icons.add),
),



    );
  }
}
