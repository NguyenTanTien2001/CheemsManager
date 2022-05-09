import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MetaUserModel extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? url;

  MetaUserModel({
    required this.email,
    required this.displayName,
    this.url,
    this.uid = '',
  });

  factory MetaUserModel.fromFirestore(DocumentSnapshot doc) {
    return MetaUserModel(
      uid: doc.id,
      email: doc['email'],
      displayName: doc['display_name'],
      url: doc['url'] ?? null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
