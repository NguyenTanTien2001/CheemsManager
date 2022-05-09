import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/fire_store_services.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firestoreServicesProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(ref.read(firebaseFirestoreProvider));
});
