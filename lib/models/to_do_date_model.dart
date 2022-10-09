import 'package:table_calendar/table_calendar.dart';

class ToDoDateModel {
  //final DateTime day;
  final String focusedDay;
  final String selectedDay;
  final CalendarFormat format;

  ToDoDateModel(
      {this.focusedDay = "", this.selectedDay = "",
        this.format = CalendarFormat.month
      });

  // bool isTask = false, isMonth;
  const ToDoDateModel.empty()
      : this.focusedDay = "",
        this.selectedDay = "",
        this.format = CalendarFormat.month;

  ToDoDateModel copyWith(
      {String? focusedDay, String? selectedDay, CalendarFormat? format}) {
    return ToDoDateModel(
        focusedDay: focusedDay ?? this.focusedDay,
        selectedDay: selectedDay ?? this.selectedDay,
        format: format ?? this.format);
  }

  // String toString() {
  //   return this.day.toString() +
  //       this.isTask.toString() +
  //       this.isMonth.toString();
  // }
}
