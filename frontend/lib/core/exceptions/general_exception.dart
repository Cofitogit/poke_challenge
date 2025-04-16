class GeneralException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const GeneralException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => statusCode != null 
      ? 'Lo Pokelamentamos: $message (statusCode: $statusCode)' 
      : 'Lo Pokelamentamos: $message';
} 