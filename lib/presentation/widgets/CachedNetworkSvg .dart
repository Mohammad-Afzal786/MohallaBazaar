import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';

class CachedNetworkSvg extends StatefulWidget {
  final String url; // SVG ka network URL

  const CachedNetworkSvg({required this.url, super.key});

  @override
  State<CachedNetworkSvg> createState() => _CachedNetworkSvgState();
}

class _CachedNetworkSvgState extends State<CachedNetworkSvg> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadAndCacheSvg();
  }

  Future<void> _loadAndCacheSvg() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final filename = widget.url.split('/').last;
      final filePath = '${cacheDir.path}/$filename';
      final file = File(filePath);

      if (await file.exists()) {
        if (!mounted) return; // ✅ widget tree me hai ya nahi check karo
        setState(() => localPath = filePath);
      } else {
        final response = await http.get(Uri.parse(widget.url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          if (!mounted) return; // ✅ yaha bhi check
          setState(() => localPath = filePath);
        } else {
          debugPrint("Failed to load SVG: ${response.statusCode}");
        }
      }
    } catch (e) {
      debugPrint("Error in _loadAndCacheSvg: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (localPath == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SvgPicture.file(
        File(localPath!),
        fit: BoxFit.contain,
      );
    }
  }
}
