import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';
import 'package:mohalla_bazaar/modules/update_apk/update_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';

class UpdateManager {
  final BuildContext context;
  UpdateManager(this.context);

  /// 🔍 Step 1: Check update from API
  Future<void> checkForUpdate() async {
    try {
      final dio = Dio();
      final res = await dio.get(

        "${AppStrings.baseurladmin}appversion"
      );

      final apiData = res.data['data'] ?? {};
      final latestVersion = apiData['latestVersion'] as String?;
      final apkUrl = apiData['apkUrl'] as String?;
      final changelog = apiData['changelog'] as String? ?? "";
      final forceUpdate = apiData['forceUpdate'] as bool? ?? false;

      if (latestVersion == null || apkUrl == null) return;

      final info = await PackageInfo.fromPlatform();
      final currentVersion = info.version;

       if (_isVersionLower(currentVersion, latestVersion)) {
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: forceUpdate,
            builder: (_) => UpdatePage(
              latestVersion: latestVersion,
              changelog: changelog,
              apkUrl: apkUrl,
              forceUpdate: forceUpdate,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("❌ Error checking update: $e");
    }
  }

  /// Compare version strings
  bool _isVersionLower(String current, String latest) {
    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();
    for (int i = 0; i < latestParts.length; i++) {
      if (i >= currentParts.length || currentParts[i] < latestParts[i]) return true;
      if (currentParts[i] > latestParts[i]) return false;
    }
    return false;
  }

  /// 🔔 Step 2: Show Cupertino Update Dialog
  void _showUpdateDialog(
      String latestVersion, String changelog, String apkUrl, bool forceUpdate) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Update Available"),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "A new version ($latestVersion) is available.\n\n$changelog",
          ),
        ),
        actions: [
          if (!forceUpdate)
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text("Later"),
            ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.pop(context);
              await _downloadAndInstallApk(apkUrl);
            },
            child: const Text("Update Now"),
          ),
        ],
      ),
    );
  }

  /// 🧩 Step 3: Ask Storage Permission (Cupertino flow)
  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    if (await Permission.manageExternalStorage.isGranted ||
        await Permission.storage.isGranted) {
      return true;
    }

    PermissionStatus status;
    if (await Permission.manageExternalStorage.isDenied) {
      status = await Permission.manageExternalStorage.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) return true;

    if (status.isDenied) {
      final retry = await _showPermissionDialog(
        "Storage permission is required to download the update.",
        "Grant",
      );
      if (retry == true) {
        return await _requestStoragePermission();
      }
      return false;
    }

    if (status.isPermanentlyDenied) {
      final openSettings = await _showPermissionDialog(
        "Storage permission permanently denied.\nPlease enable it manually in settings.",
        "Open Settings",
      );
      if (openSettings == true) {
        await openAppSettings();
      }
      return false;
    }

    return false;
  }

  /// 📦 Step 4: Download APK (Cupertino progress)
  Future<void> _downloadAndInstallApk(String url) async {
    final granted = await _requestStoragePermission();
    if (!granted) return;

    final dir = await getExternalStorageDirectory();
    if (dir == null) return;

    final savePath = "${dir.path}/MohallaBazaar.apk";
    final dio = Dio();
    final progressNotifier = ValueNotifier<double>(0.0);

    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ValueListenableBuilder<double>(
        valueListenable: progressNotifier,
        builder: (context, value, _) => CupertinoAlertDialog(
          title: const Text("Downloading Update"),
          content: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                CupertinoActivityIndicator.partiallyRevealed(
                  progress: value.clamp(0.0, 1.0),
                ),
                const SizedBox(height: 8),
                Text("${(value * 100).toStringAsFixed(0)}%"),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) progressNotifier.value = received / total;
        },
      );

      Navigator.of(context).pop(); // Close dialog
      _installApk(savePath);
    } catch (e) {
      Navigator.of(context).pop();
      _showCupertinoSnack("❌ Error downloading update: $e");
    }
  }

  /// ⚙️ Step 5: Trigger installer via MethodChannel
  void _installApk(String filePath) async {
    if (!Platform.isAndroid) return;

    try {
      const channel = MethodChannel('update_manager');
      await channel.invokeMethod('installApk', {"filePath": filePath});
    } catch (e) {
      _showCupertinoSnack("❌ Error triggering install: $e");
    }
  }

  /// 🪟 Helper: Cupertino permission alert
  Future<bool?> _showPermissionDialog(String message, String actionText) async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Permission Required"),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(message),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  /// 🍎 Helper: Cupertino Snack (replacement for ScaffoldMessenger)
  void _showCupertinoSnack(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Notice"),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(message),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
