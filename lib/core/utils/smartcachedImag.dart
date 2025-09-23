import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cache_manager.dart';

class SmartCachedImage extends StatefulWidget {
  final String imageUrl;
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
  @override
  void initState() {
    super.initState();
    // Background fetch to update cache
    _updateCache();
  }

  Future<void> _updateCache() async {
    // Disk & network cache update
    await MyCacheManager().getSingleFile(widget.imageUrl);
    // No need to change _displayedUrl, CachedNetworkImage handles it
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: MyCacheManager(),
      imageUrl: widget.imageUrl,      // Always use URL
      width: widget.width,
        fit: widget.fit,
      height: widget.height,
     
     
      errorWidget: (context, url, error) => Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: Icon(Icons.error),
      ),
      fadeInDuration: Duration.zero,
    );
  }
}
