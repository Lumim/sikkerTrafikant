class CalendarEvent {
  final String id;
  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final String type;
  final bool reminderEnabled;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.startAt,
    required this.endAt,
    required this.type,
    required this.reminderEnabled,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      startAt: DateTime.parse(json['startAt']),
      endAt: DateTime.parse(json['endAt']),
      type: json['type'],
      reminderEnabled: json['reminderEnabled'] ?? false,
    );
  }
}
