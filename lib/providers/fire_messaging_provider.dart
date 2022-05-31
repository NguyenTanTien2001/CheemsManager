import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/fire_store_services.dart';
import '../services/firestore_messing_service.dart';

final firebaseMessagingServiceProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final firestoreMessagingServiceProvider =
    Provider<FirestoreMessagingService>((ref) {
  return FirestoreMessagingService(ref.read(firebaseMessagingServiceProvider));
});
