import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetPhoto extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? radius;

  const NetPhoto({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, _) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, _, __) => const Icon(Icons.broken_image),
      width: width,
      height: height,
      fit: fit,
    );

    if (radius != null) {
      return ClipRRect(borderRadius: radius!, child: image);
    }
    return image;
  }
}
