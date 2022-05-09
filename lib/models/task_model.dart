import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TaskModel extends Equatable {
  String id;
  final String idAuthor;
  final String idProject;
  final String title;
  final String description;
  final DateTime dueDate;
  final DateTime startDate;
  final List<String> listMember;
  bool completed;
  String desUrl;

  TaskModel({
    this.id = '',
    required this.idAuthor,
    required this.idProject,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.startDate,
    required this.listMember,
    this.completed = false,
    this.desUrl = '',
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    List<String> list = [];
    for (int i = 0; i < doc['list_member'].length; i++) {
      list.add(doc['list_member'][i]);
    }
    return TaskModel(
        id: doc.id,
        idAuthor: doc['id_author'],
        idProject: doc['id_project'],
        title: doc['title'],
        description: doc['description'],
        dueDate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc['due_date']),
        startDate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc['start_date']),
        listMember: list,
        completed: doc['completed'],
        desUrl: doc['des_url']);
  }

  Map<String, dynamic> toFirestore() => {
        'id_author': this.idAuthor,
        'id_project': this.idProject,
        'title': this.title,
        'description': this.description,
        'due_date': DateFormat("yyyy-MM-dd hh:mm:ss").format(this.dueDate),
        'start_date': DateFormat("yyyy-MM-dd hh:mm:ss").format(this.startDate),
        'list_member': this.listMember,
        'completed': this.completed,
        'des_url': this.desUrl
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
