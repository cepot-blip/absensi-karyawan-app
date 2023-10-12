import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(
              formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          focusedDay: today,
          firstDay: DateTime(2010, 10, 16),
          lastDay: DateTime(2050, 10, 16),
        ),
      ],
    );
  }
}
