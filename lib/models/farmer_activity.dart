class FarmerActivity {
  final String title;
  final String? description;
  final DateTime date;
  final bool isAllDay;
  final String? location;
  final String type;
  final String? reminder;

  FarmerActivity({
    required this.title,
    required this.date,
    this.description,
    this.isAllDay = true,
    this.location,
    this.type = 'General',
    this.reminder,
  });
}