class CustomException implements Exception {
  final dynamic error;
  final String errorMessage;
  final StackTrace? stackTrace;
  final String errorCode;

  CustomException({
    required this.error,
    required this.errorMessage,
    this.stackTrace,
    required this.errorCode,
  });
}
