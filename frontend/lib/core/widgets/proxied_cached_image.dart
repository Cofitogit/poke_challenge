import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../services/image_proxy_service.dart';

class ProxiedCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String)? placeholder;

  const ProxiedCachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final proxiedUrl = ImageProxyService.getProxiedImageUrl(imageUrl);
    
    return CachedNetworkImage(
      imageUrl: proxiedUrl,
      height: height,
      fit: fit,
      placeholder: placeholder != null 
          ? (context, url) => placeholder!(context, url)
          : (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
      errorWidget: errorWidget != null
          ? (context, url, error) => errorWidget!(context, url, error)
          : (context, url, error) => const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
    );
  }
} 