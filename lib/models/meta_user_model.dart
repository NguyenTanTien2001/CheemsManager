import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MetaUserModel extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? url;
  final String? token;

  MetaUserModel({
    required this.email,
    required this.displayName,
    this.url,
    this.uid = '',
    this.token = '',
  });

  factory MetaUserModel.fromFirestore(DocumentSnapshot doc) {
    print(doc.data().toString());
    return MetaUserModel(
      uid: doc.id,
      email: doc['email'],
      displayName: doc['display_name'],
      url: doc.data().toString().contains('url') ? doc['url'] : null,
      token: doc.data().toString().contains('messingToken')
          ? doc['messingToken']
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
