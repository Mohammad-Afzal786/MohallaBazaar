import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cache_manager.dart';

class SmartCachedImage extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SmartCachedImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  State<SmartCachedImage> createState() => _SmartCachedImageState();
}

class _SmartCachedImageState extends State<SmartCachedImage> {
  bool _isCached = false;

  @override
  void initState() {
    super.initState();
    _checkCache();
  }

  Future<void> _checkCache() async {
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      final fileInfo = await MyCacheManager().getFileFromCache(widget.imageUrl!);
       if (!mounted) return; 
      if (fileInfo != null) {
        setState(() {
          _isCached = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: Icon(Icons.image_not_supported, size: 40, color: Colors.white54),
      );
    }

    return CachedNetworkImage(
      cacheManager: MyCacheManager(),
      imageUrl: widget.imageUrl!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      fadeInDuration: Duration.zero,

      // ✅ Only show placeholder if image is not cached
      placeholder: _isCached
          ? (_, __) => SizedBox.shrink() // cached → no loading indicator
          : (context, url) => Container(
              width: widget.width,
              height: widget.height,
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),

      errorWidget: (context, url, error) => Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: Icon(Icons.broken_image, size: 40, color: Colors.white54),
      ),
    );
  }
}
