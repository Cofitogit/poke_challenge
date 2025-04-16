import 'package:frontend/core/services/index.dart';

/// Service to handle image proxying through the backend
class ImageProxyService {
  static const String _baseProxyUrl = '${NetworkStrings.backendUrl}/proxy/image';
  
  /// Converts an external URL to a proxy URL
  /// to avoid CORS issues
  static String getProxiedImageUrl(String originalUrl) {
    // Encode the URL to ensure it's valid in a query string
    final encodedUrl = Uri.encodeComponent(originalUrl);

    return '$_baseProxyUrl?url=$encodedUrl';
  }
} 