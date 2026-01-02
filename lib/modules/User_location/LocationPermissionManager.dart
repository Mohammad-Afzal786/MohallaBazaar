import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionManager {
  final BuildContext context;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  LocationPermissionManager(this.context);

  /// 🔹 Main entry
  Future<void> ensurePermissionAndFetch({
    required Future<void> Function() onLocationFetched,
  }) async {
    if (!context.mounted) return;

    isLoading.value = true;

    try {
      // Step 1: Ensure location service
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        final open = await _showOpenSettingsDialog(
          title: "Location services off",
          message: "Please enable location services to continue.",
          openLabel: "Open Settings",
        );
        if (open == true) await Geolocator.openLocationSettings();
        isLoading.value = false;
        return;
      }

      // Step 2: Permission request loop
      bool permissionGranted = false;
      while (!permissionGranted) {
        var status = await Permission.location.status;

        if (status.isGranted) {
          permissionGranted = true;
          break;
        }

        final result = await Permission.location.request();

        if (result.isGranted) {
          permissionGranted = true;
          break;
        } else if (result.isDenied) {
          // ❌ User rejected → show snack & loop again
          await _showSnack("Location permission required to continue");
          await Future.delayed(const Duration(milliseconds: 300));
        } else if (result.isPermanentlyDenied) {
          // ⚠️ Permanently denied → open settings
          final openSettings = await _showOpenSettingsDialog(
            title: "Permission Required",
            message:
                "Location permission permanently denied. Please enable it in app settings.",
            openLabel: "Open Settings",
          );
          if (openSettings == true) await openAppSettings();
          break;
        }
      }

      // Step 3: Fetch location if permission granted
      if (permissionGranted) {
        await onLocationFetched();
      }
    } catch (e) {
      debugPrint("❌ Location/permission error: $e");
    } finally {
      if (context.mounted) isLoading.value = false;
    }
  }

  /// 🪟 Show Cupertino snack
  Future<void> _showSnack(String message) async {
    if (!context.mounted) return;
    await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Text(message),
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

  /// ⚙️ Open settings dialog
  Future<bool?> _showOpenSettingsDialog({
    required String title,
    required String message,
    required String openLabel,
  }) async {
    if (!context.mounted) return false;
    return showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
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
            child: Text(openLabel),
          ),
        ],
      ),
    );
  }
}
