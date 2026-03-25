import 'package:dio/dio.dart';
import '../domain/calendar_event.dart';

class CalendarRepository {
  final Dio dio;

  CalendarRepository(this.dio);

  Future<List<CalendarEvent>> fetchEvents() async {
    final response = await dio.get('/calendar/events');
    final data = response.data as List;
    return data.map((e) => CalendarEvent.fromJson(e)).toList();
  }
}
