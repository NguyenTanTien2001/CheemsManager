import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirestoreMessagingService {
  final FirebaseMessaging _firebaseMessaging;
  FirestoreMessagingService(this._firebaseMessaging);
  String currentToken = '';
  String serverKey =
      'AAAA32s0fJA:APA91bHhkn8ptI0BDo1Om3vlNR-KrPT_vihl8ak63IC4Ak0OC_S2KtdPAZriahidO_ymZjZPq_iZD3PDuTkQbSwLBVJsFCB4WWA7TNulgDSGq-7DYcm7FjwAsJ3JaThXTN93I38cdeVG';

  getToken() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null)
      FirebaseMessaging.instance.getToken().then((value) => {
            this.currentToken = value!,
            print("uit: ${uid}, token: ${value}"),
            saveToken(uid, value)
          });
  }

  saveToken(String uid, String token) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .update({"messingToken": token});
  }

  Future<String> sendPushMessaging(
      String desToken, String title, String body) async {
    if (desToken == null) {
      print('Unable to send FCM message, no token exists.');
      return "no token exists";
    }

    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': 'key=$serverKey',
        },
        body: jsonEncode({
          'token': currentToken,
          'notification': <String, dynamic>{'title': title, 'body': body},
          "android": {"priority": "normal"},
          "apns": {
            "headers": {"apns-priority": "5"}
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "fcm_options": {
            //'send': '$currentToken',
          },
          'to': desToken,
        }),
      );
      print('FCM request for device sent!');
      //print(res.body);
      return "success send message";
    } catch (e) {
      print(e);
      return "error while sending message";
    }
  }
}
