import 'package:fa_dart_logger/src/logger/helper/log_helper.dart';
import 'package:logger/logger.dart';

import 'base/app_log.dart';
import 'logger/model/index.dart';
import 'logger/output/my_console_output.dart';
import 'logger/printer/my_pretty_printer.dart';

class AppLogImpl implements AppLog {
  AppLogImpl({this.packageName}) {
    _logger = Logger(
      printer: MyPrettyPrinter(),
      output: MyConsoleOutput(
        packageName: packageName,
      ),
    );
  }

  final String? packageName;
  late Logger _logger;

  UserInfo? _userInfo;

  // ignore: avoid_setters_without_getters
  set userInfo(UserInfo userInfo) {
    _userInfo = userInfo;
  }

  @override
  void d(object) {
    _logger.d(object);
  }

  @override
  void e(object, StackTrace s) {
    _logger.e(object, null, s);
  }

  @override
  void i(object) {
    _logger.i(object);
  }

  @override
  void v(object) {
    _logger.v(object);
  }

  @override
  void w(object) {
    _logger.w(object);
  }

  @override
  void wtf(object) {
    _logger.wtf(object);
  }

  /// [userInfo] must be set, before calling this method
  @override
  void r(
    LogInfo logInfo, {
    Severity severity = Severity.high,
  }) {
    if (_userInfo == null) {
      d("Initialise user info before calling this method");
      return;
    }

    /// TODO(@singhtaranjeet): Will capture the priority from remote config
    const remotePriority = Severity.high;

    if (shouldCaptureLog(
        remoteSeverity: remotePriority, logSeverity: severity)) {
      // Log the data to API Logger
      final logData =
          ApiLogInfo.fromLogInfo(logInfo: logInfo, userInfo: _userInfo!);

      /// TODO(@singhtaranjeet): call remote log api
      _logger.i(logData);
    }
  }
}
