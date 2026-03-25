import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../data/calendar_repository.dart';
import '../domain/calendar_event.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository(ref.read(dioProvider));
});

class CalendarState {
  final bool isLoading;
  final List<CalendarEvent> events;
  final String viewMode;
  final String? error;

  const CalendarState({
    this.isLoading = false,
    this.events = const [],
    this.viewMode = 'list',
    this.error,
  });

  CalendarState copyWith({
    bool? isLoading,
    List<CalendarEvent>? events,
    String? viewMode,
    String? error,
  }) {
    return CalendarState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      viewMode: viewMode ?? this.viewMode,
      error: error,
    );
  }
}

final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>(
  (ref) {
    return CalendarNotifier(ref.read(calendarRepositoryProvider));
  },
);

class CalendarNotifier extends StateNotifier<CalendarState> {
  final CalendarRepository repository;

  CalendarNotifier(this.repository) : super(const CalendarState());

  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final events = await repository.fetchEvents();
      state = state.copyWith(isLoading: false, events: events);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setViewMode(String mode) {
    state = state.copyWith(viewMode: mode);
  }
}
