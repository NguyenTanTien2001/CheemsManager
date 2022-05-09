import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class CommentModel extends Equatable {
  String id;
  final String userId;
  final String text;
  final String? url;
  final DateTime time;

  CommentModel(
      {this.id = '',
      required this.userId,
      required this.text,
      this.url = '',
      required this.time});

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    return CommentModel(
      id: doc.id,
      userId: doc['user_id'],
      text: doc['text'],
      url: doc['url'],
      time: DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc['time']),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'text': text,
        'url': url,
        'time': DateFormat("yyyy-MM-dd hh:mm:ss").format(time),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
