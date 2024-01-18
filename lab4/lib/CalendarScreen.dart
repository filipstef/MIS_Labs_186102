// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Utils.dart';

class CalendarScreen extends StatefulWidget {
  Function back;
  Function dateToSort;
  Function clearDateSort;
  CalendarScreen(this.back, this.dateToSort, this.clearDateSort);

  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  _CalendarScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;

                    final DateFormat formatter = DateFormat('dd-MM-yyyy');
                    final String formatted = formatter.format(selectedDay);

                    this.widget.dateToSort(formatted);
                    this.widget.back();
                  });
                }
              }),
          TextButton(
              child: Text("Clear sort"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  this.widget.clearDateSort();
                  this.widget.back();
                });
              })
        ]));
  }
}
