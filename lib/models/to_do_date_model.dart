import 'package:equatable/equatable.dart';

class ToDoDateModel extends Equatable {
  final DateTime day;
  bool isTask = false, isMonth;
  ToDoDateModel({required this.day, this.isMonth = true});

  String toString() {
    return this.day.toString() +
        this.isTask.toString() +
        this.isMonth.toString();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [day];
}
