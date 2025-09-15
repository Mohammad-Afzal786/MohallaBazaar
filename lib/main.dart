import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/auth/auth_injection.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mohalla_bazaar/modules/notification/push_notification_service.dart';
import '/config/firebase_options.dart';
import 'app.dart';
const String baseUrl = "http://10.0.2.2:3000/api/";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Local Storage init
  await GetStorage.init();

  // ✅ Push Notification init
  await PushNotificationService.init();

  await initAuthInjection(baseUrl: baseUrl);

  runApp(
    DevicePreview(
      enabled: false, // 👈 mobile preview enable
      builder: (context) => const MyApp(),
    ),
  );
  bool hasHandledError = false; // track first error

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);

    if (!hasHandledError) {
      hasHandledError = true;
      print("First widget error caught: ${details.exception}");
    } else {
      // Skip showing the debug red screen again
      FlutterError.dumpErrorToConsole(details); // optional, just log
    }
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    print("Zone error caught: $error");
  });
}