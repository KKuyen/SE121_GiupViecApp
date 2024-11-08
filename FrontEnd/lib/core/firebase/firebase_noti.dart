import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNoti {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    final fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');
  }
}
