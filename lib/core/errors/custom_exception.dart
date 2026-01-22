class CustomException implements Exception {
  final String exceptionMeassge;
  CustomException({required this.exceptionMeassge});
  @override
  String toString() {
    return exceptionMeassge;
  }
}
