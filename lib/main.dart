import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/auth_injection.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';

import 'app.dart';
const String baseUrl = "http://10.0.2.2:3000/api/";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase init
 // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Local Storage init
  await GetStorage.init();

  // ✅ Push Notification init
 

  await initInjection(baseUrl: baseUrl);

  runApp(
    DevicePreview(
      enabled: false, // 👈 mobile preview enable
      builder: (context) => const MyApp(),
    ),
  );
 
 
// DashboardController ko globally aur permanently register karte hain
  Get.put<DashboardController>(DashboardController(), permanent: true);

  


}