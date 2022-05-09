import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final int id;
  final String text;
  bool check;

  NoteModel({required this.id, required this.text, this.check = true});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
