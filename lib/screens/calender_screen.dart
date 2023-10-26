import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {
  final String title;
  final String description;

  Event(this.title, this.description);
}

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _eventController = TextEditingController();
  String _eventTime = ''; // Variabel untuk menyimpan waktu acara
  Map<DateTime, List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventForDay(DateTime day) {
    return events[day] ?? [];
  }

  String _extractTime(String eventDescription) {
    final List<String> lines = eventDescription.split('\n');
    for (String line in lines) {
      if (line.startsWith('Jam: ')) {
        return line.substring(5);
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text("Tambah Acara"),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _eventController,
                        decoration:
                            const InputDecoration(labelText: 'Nama Acara'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Text('Pilih Jam: '),
                          ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? selectedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                final String formattedTime =
                                    '${selectedTime.hour}:${selectedTime.minute}';
                                setState(() {
                                  _eventTime = formattedTime;
                                });
                              }
                            },
                            child: const Text('Pilih Jam'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (_eventController.text.isEmpty || _eventTime.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Kesalahan"),
                              content: const Text(
                                  'Nama acara dan waktu tidak boleh kosong.'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        final String eventDescription =
                            'Nama Acara: ${_eventController.text}\nJam: $_eventTime';
                        if (events.containsKey(_selectedDay!)) {
                          events[_selectedDay!]!
                              .add(Event("Event Title", eventDescription));
                        } else {
                          events[_selectedDay!] = [
                            Event("Event Title", eventDescription)
                          ];
                        }
                        _eventController.clear();
                        _eventTime = '';
                        Navigator.of(context).pop();
                        _selectedEvents.value = _getEventForDay(_selectedDay!);
                      }
                    },
                    child: const Text("Konfirmasi"),
                  ),
                ],
              );
            },
          );
        },
        mini: true,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            availableGestures: AvailableGestures.all,
            eventLoader: _getEventForDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            focusedDay: _focusedDay,
            firstDay: DateTime(2010, 10, 16),
            lastDay: DateTime(2050, 10, 16),
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      color: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Detail Acara"),
                                  content: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(value[index].description),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          title: Text(
                            value[index].description,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            selectionColor: Colors.blue,
                          )),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({Key? key}) : super(key: key);

  @override
  State<DigitalClockWidget> createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final String formattedTime = DateFormat.jm().format(DateTime.now());
    setState(() {
      _formattedTime = formattedTime;
    });

    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedTime,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.blue,
      ),
    );
  }
}
