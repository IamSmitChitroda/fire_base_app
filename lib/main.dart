import 'package:fire_base_app/headers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    sound: true,
  );

  String? token = await messaging.getToken();
  if (token != null) {
    Logger().i('fcm token: $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('fcm_token', token);
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseHandler);

  FirebaseMessaging.onMessage.listen(
    (message) async {
      await LocalNotificationService.showNotification();
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) async {
      await LocalNotificationService.showNotification();
    },
  );

  await LocalNotificationService.initialize();

  runApp(const MyApp());
}

Future<void> _firebaseHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
