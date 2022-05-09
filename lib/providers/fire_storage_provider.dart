import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/services/fire_storage_services.dart';

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

final fireStorageServicesProvider = Provider<FireStorageService>((ref) {
  return FireStorageService(ref.read(firebaseStorageProvider));
});
