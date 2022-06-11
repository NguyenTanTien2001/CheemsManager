import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list/services/firestore_messing_service.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:rxdart/rxdart.dart';

import '/providers/auth_provider.dart';
import '/providers/fire_storage_provider.dart';
import '/providers/fire_store_provider.dart';
import '/providers/fire_messaging_provider.dart';
import '/services/auth_services.dart';
import '/services/fire_storage_services.dart';
import '/services/fire_store_services.dart';

abstract class BaseViewModel {
  BehaviorSubject<bool> bsLoading = new BehaviorSubject.seeded(false);
  BehaviorSubject<bool> bsRunning = new BehaviorSubject.seeded(false);

  final AutoDisposeProviderReference ref;
  late final FirestoreService firestoreService;
  late final AuthenticationService auth;
  late final FireStorageService fireStorageService;
  late final FirestoreMessagingService firestoreMessagingService;
  User? user;

  BaseViewModel(this.ref) {
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestoreService = ref.watch(firestoreServicesProvider);
    fireStorageService = ref.watch(fireStorageServicesProvider);
    firestoreMessagingService = ref.watch(firestoreMessagingServiceProvider);
  }

  @mustCallSuper
  void dispose() {
    bsRunning.close();
    bsLoading.close();
  }

  showLoading() => bsLoading.add(true);

  closeLoading() => bsLoading.add(false);

  startRunning() => bsRunning.add(true);

  endRunning() => bsRunning.add(false);
}
