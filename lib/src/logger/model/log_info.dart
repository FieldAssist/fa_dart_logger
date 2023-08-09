import 'package:fa_dart_logger/fa_dart_logger.dart';

/// Use this for logging remotely logger.r()
class LogInfo {
  LogInfo({
    this.endpoint,
    this.method,
    this.response,
    this.request,
    this.error,
    this.stackTrace,
    this.warning,
    this.message,
    String? severity,
  })  : severity = severity ?? Severity.high.name.toLowerCase(),
        date = DateTime.now().toIso8601String();

  final String? endpoint;
  final String? method;
  final String? response;
  final String? request;
  final String? error;
  final StackTrace? stackTrace;
  final String? warning;
  final String? message;
  final String severity;
  final String date;

  @override
  String toString() {
    return """LogInfo{endpoint: $endpoint, method: $method, response: $response, request: $request, error: $error, stackTrace: $stackTrace, warning: $warning, message: $message}, severity: $severity date: $date""";
  }
}

/// Use this for send log to remote logging server
class ApiLogInfo extends LogInfo {
  ApiLogInfo({
    required this.userInfo,
    String? endpoint,
    String? method,
    String? response,
    String? request,
    String? error,
    StackTrace? stackTrace,
    String? warning,
    String? message,
    String? severity,
  })  : userInfoBatch = userInfo.getUcid(),
        super(
          endpoint: endpoint,
          method: method,
          response: response,
          request: request,
          error: error,
          stackTrace: stackTrace,
          warning: warning,
          message: message,
          severity: severity,
        );

  factory ApiLogInfo.fromLogInfo({
    required LogInfo logInfo,
    required UserInfo userInfo,
  }) {
    return ApiLogInfo(
      endpoint: logInfo.endpoint,
      method: logInfo.method,
      response: logInfo.response,
      request: logInfo.request,
      error: logInfo.error,
      stackTrace: logInfo.stackTrace,
      warning: logInfo.warning,
      message: logInfo.message,
      userInfo: userInfo,
    );
  }

  final UserInfo userInfo;

  /// This batch is just user info seperated by underscore for better searching
  /// for example: userName_id_companyId
  final String userInfoBatch;

  @override
  String toString() {
    return """ApiLogInfo{endpoint: $endpoint, method: $method, response: $response, request: $request, error: $error, stackTrace: $stackTrace, warning: $warning, message: $message, userInfo: $userInfo} userInfoBatch: $userInfoBatch, severity: $severity date: $date""";
  }

  Map<String, dynamic> toJson() {
    return {
      "endpoint": endpoint,
      "method": method,
      "response": response,
      "request": request,
      "error": error,
      "stackTrace": stackTrace.toString(),
      "warning": warning,
      "message": message,
      "userInfo": userInfo.toJson(),
      "userInfoBatch": userInfoBatch,
      "severity": severity,
      "date": date,
    };
  }
}
