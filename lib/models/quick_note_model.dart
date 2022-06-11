import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/note_model.dart';

class QuickNoteModel extends Equatable {
  String id;
  final String content;
  final int indexColor;
  final DateTime time;
  List<NoteModel> listNote;
  bool isSuccessful;

  QuickNoteModel({
    this.id = '',
    required this.content,
    required this.indexColor,
    required this.time,
    this.isSuccessful = false,
    this.listNote = const [],
  });

  factory QuickNoteModel.fromJson(Map<String, dynamic> json) {
    List<NoteModel> _list = [];
    for (int i = 0; i < (json['list.length'] ?? 0); i++) {
      _list.add(
        new NoteModel(
            id: i,
            text: json['list.data_$i.note'],
            check: json['list.data_$i.check']),
      );
    }
    return QuickNoteModel(
      id: json['id'],
      content: json['content'],
      indexColor: json['index_color'],
      time: DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['time']),
      isSuccessful: json['is_successful'],
      listNote: _list,
    );
  }

  factory QuickNoteModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<NoteModel> _list = [];

    for (int i = 0; i < (doc['list.length'] ?? 0); i++) {
      _list.add(
        new NoteModel(
          id: i,
          text: doc['list.data_$i.note'],
          check: doc['list.data_$i.check'],
        ),
      );
    }

    return QuickNoteModel(
      id: doc.id,
      content: data['content'],
      indexColor: data['index_color'],
      time: DateFormat("yyyy-MM-dd hh:mm:ss").parse(data['time']),
      isSuccessful: data['is_successful'],
      listNote: _list,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'content': this.content,
        'index_color': this.indexColor,
        'time': DateFormat("yyyy-MM-dd hh:mm:ss").format(this.time),
        'is_successful': this.isSuccessful,
        'list': {
          'length': listNote.length,
          for (int i = 0; i < listNote.length; i++)
            'data_$i': {
              'note': listNote[i].text,
              'check': listNote[i].check,
            }
        }
      };

  Map<String, dynamic> toFirestore() => {
        'content': this.content,
        'index_color': this.indexColor,
        'time': DateFormat("yyyy-MM-dd hh:mm:ss").format(this.time),
        'is_successful': this.isSuccessful,
        'list': {
          'length': listNote.length,
          for (int i = 0; i < listNote.length; i++)
            'data_$i': {
              'note': listNote[i].text,
              'check': listNote[i].check,
            }
        }
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
