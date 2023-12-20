import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir2/screens/home_screen.dart';
import 'package:tugas_akhir2/widget/EventContent.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalenderScreen> {
  // PROPERTI
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  String _timeError = '';
  Map<DateTime, List<Event>?> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;
  String selectedDayOfWeek = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // LIFECYCLE METHOD
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventForDay(_selectedDay!));

    selectedDayOfWeek = getDayOfWeek(_selectedDay!);
  }

  // HELPHER METHOD
  List<Event> _getEventForDay(DateTime day) {
    return events[day] ?? [];
  }

  String getDayOfWeek(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE');
    return formatter.format(date);
  }

  // HANDLER ACARA
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventForDay(selectedDay);
      });

      final dayOfWeek = getDayOfWeek(selectedDay);

      setState(() {
        selectedDayOfWeek = dayOfWeek;
      });
    }
  }

  //KONFIRMASI HAPUS EVENT
  Future<void> _confirmDeleteEvent(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Anda yakin ingin menghapus acara ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus'),
              style: TextButton.styleFrom(),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  events[_selectedDay!]!.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }

  // BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender Karyawan"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TAMPILAN DIALOG TAMBAH ACARA
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Center(
                  child: Text(
                    "Tambah Acara",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                    ),
                  ),
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // INPUT NAMA ACARA
                      SizedBox(
                        width: 280,
                        child: TextFormField(
                          controller: _eventController,
                          decoration: InputDecoration(
                            labelText: 'Nama Acara',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Nama acara harus diisi.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // INPUT LOKASI
                      SizedBox(
                        width: 280,
                        child: TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            labelText: 'Lokasi',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Lokasi harus diisi.';
                            }
                            return null;
                          },
                        ),
                      ),
                      // INPUT WAKTU
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // INPUT WAKTU MULAI
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: TextField(
                              controller: _startTime,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 1),
                                hintText: '   00:00',
                                border: UnderlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                setState(() {
                                  if (time != null) {
                                    final formattedTime =
                                        DateFormat('\t\t\tHH:mm')
                                            .format(DateTime(
                                      _selectedDay!.year,
                                      _selectedDay!.month,
                                      _selectedDay!.day,
                                      time.hour,
                                      time.minute,
                                    ));
                                    _startTime.text = formattedTime;
                                  }
                                });
                              },
                            ),
                          ),
                          const Text(
                            'to',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                          // INPUT WAKTU SELESAI
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: TextField(
                              controller: _endTime,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 1),
                                hintText: '   00:00',
                                border: UnderlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                setState(() {
                                  if (time != null) {
                                    final formattedTime =
                                        DateFormat('\t\t\tHH:mm')
                                            .format(DateTime(
                                      _selectedDay!.year,
                                      _selectedDay!.month,
                                      _selectedDay!.day,
                                      time.hour,
                                      time.minute,
                                    ));
                                    _endTime.text = formattedTime;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      // PESAN KESALAHAN WAKTU
                      if (_timeError.isNotEmpty)
                        Text(
                          _timeError,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                actions: [
                  // TOMBOL KONFIRMASI
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_startTime.text.isEmpty || _endTime.text.isEmpty) {
                          setState(() {
                            _timeError = 'Jam harus dipilih.';
                          });
                        } else {
                          setState(() {
                            _timeError = '';
                          });
                          // BUAT KONTEN ACARA
                          final String eventContent =
                              '${_startTime.text}\t\t|\t\t${_eventController.text}\n${_endTime.text}\t\t|\t\t${_locationController.text}';
                          // Perbarui Acara
                          if (events.containsKey(_selectedDay!)) {
                            events[_selectedDay!]!
                                .add(Event("Event Title", eventContent));
                          } else {
                            events[_selectedDay!] = [
                              Event("Event Title", eventContent)
                            ];
                          }
                          // DELETE KOLOM TEKS
                          _eventController.clear();
                          _startTime.clear();
                          _endTime.clear();
                          _locationController.clear();
                          Navigator.of(context).pop();
                          // Perbarui Acara Terpilih
                          _selectedEvents.value =
                              _getEventForDay(_selectedDay!);
                        }
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
          // KALENDER
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
          // PEMBATAS
          const Divider(
            thickness: 2,
            color: Colors.blue,
          ),
          // TEKS HARI YANG DIPILIH
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '$selectedDayOfWeek',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          // DAFTAR ACARA
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final event = value[index];
                    final content = event.content;

                    final parts = content.split('\n');

                    if (parts.length == 2) {
                      // ITEM ACARA
                      return ListTile(
                        title: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // KONTEN ACARA
                              Expanded(
                                child: InkWell(
                                  onTap: () => print(""),
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal),
                                      children: [
                                        TextSpan(
                                          text: parts[0],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        TextSpan(text: '\n'),
                                        TextSpan(
                                          text: parts[1],
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // TOMBOL HAPUS
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _confirmDeleteEvent(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
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
