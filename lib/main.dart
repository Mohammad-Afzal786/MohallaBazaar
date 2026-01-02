import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/auth_injection.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/push_notification/push_notification_service.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Local Storage
  await GetStorage.init();

  // ✅ Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ SQLite (needs path_provider → main isolate)
  await SQLiteClient.init();

  // ✅ Dependency Injection (pure Dart) → optional isolate
  await initInjection(baseUrl: AppStrings.baseurl);

  // ✅ DashboardController
  Get.put<DashboardController>(DashboardController(), permanent: true);

  // ✅ Orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // ✅ Run App immediately
  runApp(const MyApp());

  // ✅ PushNotificationService init (uses isolate internally)
  PushNotificationService.init();
}
