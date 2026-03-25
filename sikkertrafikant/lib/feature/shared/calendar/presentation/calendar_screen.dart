import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calendar_provider.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(calendarProvider.notifier).loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'list', label: Text('List')),
                ButtonSegment(value: 'grid', label: Text('Grid')),
              ],
              selected: {state.viewMode},
              onSelectionChanged: (value) {
                notifier.setViewMode(value.first);
              },
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: state.events.length,
                    itemBuilder: (context, index) {
                      final event = state.events[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(event.title),
                          subtitle: Text('${event.startAt} - ${event.endAt}'),
                          trailing: Icon(
                            event.reminderEnabled
                                ? Icons.notifications
                                : Icons.notifications_off_outlined,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
