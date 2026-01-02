import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

/// ✅ Background message handler (must have entry-point)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("📩 Background message received: ${message.messageId}");
}

/// Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize Firebase Messaging safely
  static Future<void> init() async {
    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        NavHelper.goToDashboard();
        NavHelper.goTonotificatin();
      },
    );

    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // ✅ Heavy plugin-dependent tasks on main isolate
    await _handleNotificationPermission();
    await _fetchAndStoreFCMToken();
    await _handleInitialMessage();

    // Foreground message listener
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // On notification tap when app in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NavHelper.goToDashboard();
      NavHelper.goTonotificatin();
    });
  }

  /// Fetch and store FCM token safely
  static Future<void> _fetchAndStoreFCMToken() async {
    final box = GetStorage();
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        box.write('fcmtoken', token);
        print("✅ FCM Token Saved: $token");
      }
    } catch (e) {
      print('⚠️ Failed to fetch FCM token: $e');
    }
  }

  /// Handle app launched from terminated state
  static Future<void> _handleInitialMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      NavHelper.goToDashboard();
      NavHelper.goTonotificatin();
    }
  }

  /// Foreground message handler
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification == null || android == null) return;

    BigPictureStyleInformation? bigPictureStyle;

    final imageUrl = notification.android?.imageUrl ?? message.data['image'];

    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        // ✅ Use compute isolate for pure Dart work (image download)
        final List<int> bytes = await compute<String, List<int>>(
          _downloadImageBytes,
          imageUrl,
        );

        bigPictureStyle = BigPictureStyleInformation(
          ByteArrayAndroidBitmap(Uint8List.fromList(bytes)),
          largeIcon: null,
          contentTitle: notification.title,
          summaryText: notification.body,
        );
      } catch (e) {
        print('⚠️ Error loading image: $e');
      }
    }

    final androidDetails = AndroidNotificationDetails(
      'flutter_push_channel',
      'Flutter Push Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: bigPictureStyle,
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformDetails,
    );
  }

  /// Download image in isolate (pure Dart)
  static Future<List<int>> _downloadImageBytes(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  /// Handle notification permission (Android 13+)
  static Future<void> _handleNotificationPermission() async {
    if (await Permission.notification.isGranted) return;

    if (await Permission.notification.isPermanentlyDenied) {
      print("🔒 Notifications permanently denied. Please enable in settings.");
      await openAppSettings();
      return;
    }

    final status = await Permission.notification.request();
    print(status.isGranted
        ? "✅ Notification permission granted"
        : "❌ Notification permission denied");
  }
}
