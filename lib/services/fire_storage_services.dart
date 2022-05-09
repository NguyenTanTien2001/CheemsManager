import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  final FirebaseStorage _firebaseStorage;

  FireStorageService(this._firebaseStorage);

  uploadAvatar(String filePath, String uid) async {
    File file = File(filePath);
    await _firebaseStorage.ref('user/$uid/avatar.png').putFile(file);
  }

  Future<String> loadAvatar(String uid) {
    return _firebaseStorage.ref('user/$uid/avatar.png').getDownloadURL();
  }

  uploadTaskImage(String filePath, String taskId) async {
    File file = File(filePath);
    await _firebaseStorage.ref('task/$taskId/description.png').putFile(file);
  }

  Future<String> loadTaskImage(String taskId) {
    return _firebaseStorage
        .ref('task/$taskId/description.png')
        .getDownloadURL();
  }

  uploadCommentImage(String filePath, String taskId, String commentId) {
    File file = File(filePath);
    return _firebaseStorage
        .ref('task/$taskId/comment/$commentId/description.png')
        .putFile(file);
  }

  Future<String> loadCommentImage(String taskId, String commentId) {
    return _firebaseStorage
        .ref('task/$taskId/comment/$commentId/description.png')
        .getDownloadURL();
  }
}
