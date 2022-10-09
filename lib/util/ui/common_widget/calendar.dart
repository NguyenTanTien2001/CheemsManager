import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list/models/task_model.dart';

import '/constants/constants.dart';
import '/models/to_do_date_model.dart';
import '/util/extension/extension.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    required this.getListTask,
    required this.data,
  }) : super(key: key);

  final List<TaskModel> data;
  final Function getListTask;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final ToDoDateModel toDoDateModel = ToDoDateModel();
  CalendarFormat format = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  var selectedDay;

  @override
  void initState() {
    super.initState();
    setState(() {
      toDoDateModel.copyWith(
          focusedDay: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
          format: CalendarFormat.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.KBoxShadowCard,
              offset: Offset(5, 5),
              blurRadius: 12,
            )
          ],
        ),
        child: TableCalendar<TaskModel>(
          firstDay: DateTime.parse('${DateTime.now().year - 100}-01-04'),
          lastDay: DateTime.parse('${DateTime.now().year + 100}-11-04'),
          focusedDay: this.focusedDay,
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'AvenirNextRoundedPro'),
              defaultTextStyle: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'AvenirNextRoundedPro')),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'AvenirNextRoundedPro'),
              weekendStyle: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'AvenirNextRoundedPro')),
          headerStyle: HeaderStyle(
            //formatButtonVisible: true,
            formatButtonShowsNext: false,
          ),
          onFormatChanged: (format) {
            if (this.format != format) {
              setState(() {
                this.format = format;
              });
              //toDoDateModel.copyWith(format: format);
            }
          },
          selectedDayPredicate: (day) {
            if (this.selectedDay == null) return false;
            return isSameDay(this.selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if(isSameDay(this.selectedDay, selectedDay)){
              setState(() {
                this.selectedDay = null;
              });
            } else {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            }

            widget.getListTask(selectedDay);
          },
          eventLoader: _getEventForDay,
        )
        // child: Column(
        //   children: [
        //     buildTitle(),
        //     buildHeader(),
        //     SizedBox(height: 13.w),
        //     isFullMonth ? buildMonth() : buildWeek(),
        //     SizedBox(height: isFullMonth ? 22.w.w : 5.w),
        //   ],
        // ),
        );
  }

  List<TaskModel> _getEventForDay(DateTime day){
    List<TaskModel> data = [];
    widget.data.forEach((element) {
      var dayElement = element.startDate;
      if(dayElement.year == day.year && dayElement.month == day.month && dayElement.day == day.day)
        data.add(element);
    });

    return data;
  }


}
