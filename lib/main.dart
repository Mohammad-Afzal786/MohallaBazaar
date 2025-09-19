import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mohalla_bazaar/auth_injection.dart';
import 'package:mohalla_bazaar/core/network/isar_client.dart'; // 👈 Isar service import
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'app.dart';

const String baseUrl = "http://10.0.2.2:3000/api/";


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Local Storage init (GetStorage)
  await GetStorage.init();

  // ✅ Isar DB init
  
  await IsarClient.init();

  // ✅ Dependency Injection init (remote + local + repos + blocs)
  await initInjection(baseUrl: baseUrl,);

  // ✅ DashboardController globally register (GetX)
  Get.put<DashboardController>(DashboardController(), permanent: true);

  // ✅ Run App
  runApp(
     
    DevicePreview(
      enabled: true, // 👈 preview ke liye true kar sakte ho
      builder: (context) =>  MyApp(),
     
    ),
  );
}
