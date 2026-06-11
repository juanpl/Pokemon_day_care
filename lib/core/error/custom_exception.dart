class CustomException implements Exception {
  final dynamic error;
  final String errorMessage;
  final String errorCode;

  CustomException({
    required this.error,
    required this.errorMessage,
    required this.errorCode,
  });
}
