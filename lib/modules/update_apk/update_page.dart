import 'dart:io';
 
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class UpdatePage extends StatefulWidget {
  final String latestVersion;
  final String changelog;
  final String apkUrl;
  final bool forceUpdate;

  const UpdatePage({
    super.key,
    required this.latestVersion,
    required this.changelog,
    required this.apkUrl,
    required this.forceUpdate,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final ValueNotifier<double> progressNotifier = ValueNotifier(0.0);
  bool downloading = false;

  @override
  void dispose() {
    progressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
      onWillPop: () async {
        // 🔥 BACK press = CLOSE APP
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppsColors.white,
          elevation: 0,
          centerTitle: true,
          leading: widget.forceUpdate
              ? null
              : IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () =>  SystemNavigator.pop(),
                ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "date",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                const Text(
                  "Update available",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                const Text(
                  "To use this app, download the latest version.",
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),

                const SizedBox(height: 24),

                /// APP INFO
                Row(
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 60.h,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MohallaBazaar App",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${widget.latestVersion} • Rated for 4+",
                            style: const TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  "What's new",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),

                Text(
                  "Last updated ${DateTime.now().day} "
                  "${_monthName(DateTime.now().month)} "
                  "${DateTime.now().year}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.systemGrey,
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: CupertinoScrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.changelog.isEmpty
                            ? "• Bug fixes and stability improvements."
                            : widget.changelog,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// PROGRESS
                ValueListenableBuilder<double>(
                  valueListenable: progressNotifier,
                  builder: (_, progress, __) {
                    if (!downloading) return const SizedBox.shrink();
                    final percent = (progress * 100).toStringAsFixed(0);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Downloading… $percent%",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 8,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey5,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 8,
                              width:
                                  MediaQuery.of(context).size.width * progress,
                              decoration: BoxDecoration(
                                color: AppsColors.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),

                /// UPDATE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: downloading
                        ? null
                        : () => _downloadAndInstall(widget.apkUrl),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      downloading ? "Downloading…" : "Update",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= STORAGE PERMISSION =================
  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    if (await Permission.storage.isGranted) return true;

    final status = await Permission.storage.request();
    if (status.isGranted) return true;

    await openAppSettings();
    return false;
  }

  // ================= DOWNLOAD + INSTALL =================
  Future<void> _downloadAndInstall(String url) async {
    final granted = await _requestStoragePermission();
    if (!granted) return;

    setState(() => downloading = true);

    try {
      final dir = await getExternalStorageDirectory();
      if (dir == null) throw "Storage error";

      final savePath = "${dir.path}/MohallaBazaar.apk";
      final dio = Dio();

      final file = File(savePath);
      if (file.existsSync()) file.deleteSync();

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (r, t) {
          if (t > 0) {
            progressNotifier.value = r / t;
          }
        },
      );

      await _installApk(savePath);
    } catch (e) {
      _showError("Download failed");
    } finally {
      setState(() => downloading = false);
    }
  }

  // ================= INSTALL APK =================
  Future<void> _installApk(String path) async {
    try {
      const channel = MethodChannel('update_manager');
      await channel.invokeMethod('installApk', {'filePath': path});
    } catch (e) {
      _showError("Installation failed");
    }
  }

  // ================= ERROR =================
  void _showError(String msg) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Error"),
        content: Text(msg),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ================= MONTH HELPER =================
String _monthName(int m) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[m - 1];
}
