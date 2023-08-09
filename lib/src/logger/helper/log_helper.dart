enum Severity {
  /// High Priority logs are Most important logs like errors, exceptions
  /// Agenda of high tag is to `capture less but capture rock solid information`
  high,

  /// Medium priority logs are all the things that are good to have like
  /// warnings, api logs, and all sorts of things.
  medium,

  /// Low priority logs are everything
  /// be it widget push, route information, snapshot of data.
  /// Agenda of these logs are to
  /// `Capture everything and make goldmine of data to resolve the issues`
  low,
}

Severity getSeverity(String severity) {
  switch (severity) {
    case "high":
      return Severity.high;
    case "medium":
      return Severity.medium;
    case "low":
      return Severity.low;
    default:
      return Severity.high;
  }
}

/// It is used to determine whether to capture the log or not
bool shouldCaptureLog(
    {required Severity remoteSeverity, required Severity logSeverity}) {
  if (remoteSeverity == Severity.low) {
    return true;
  }

  if (remoteSeverity == Severity.medium &&
      (logSeverity == Severity.medium || logSeverity == Severity.high)) {
    return true;
  }

  if (remoteSeverity == Severity.high && logSeverity == Severity.high) {
    return true;
  }

  return false;
}
