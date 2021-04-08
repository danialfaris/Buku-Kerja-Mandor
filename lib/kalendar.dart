import 'package:buku_kerja_mandor/main.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'drawer.dart';
import 'package:intl/intl.dart';

class Kalendar extends StatefulWidget{
  @override
  _KalendarState createState() => _KalendarState();
}

class _KalendarState extends State<Kalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Kalendar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: TableCalendar(
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              final text = 'M';
              return Center(
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              );
            }
            var days = ['S','S','R','K','J','S'];
            final text = days[day.weekday - DateTime.monday];
            return Center(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),

        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration (
            color: Color(0xFFD32F2F),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(color: Color(0x00000000)),
          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF757575))
        ),
        locale: 'in_ID',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.

          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}