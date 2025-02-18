import 'dart:convert';

import 'package:logger/logger.dart';

class MyPrettyPrinter extends LogPrinter {
  final _errorMethodCount = 10;
  final _stackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  final _levelEmojis = {
    Level.verbose: 'ℹ️ ',
    Level.debug: '🐛 ',
    Level.info: '💡 ',
    Level.warning: '⚠️ ',
    Level.error: '⛔ ',
    Level.wtf: '👾 ',
  };

  @override
  List<String> log(LogEvent event) {
    final messageStr = stringifyMessage(event.message);

    String? stackTraceStr;

    if (event.stackTrace != null) {
      stackTraceStr = formatStackTrace(event.stackTrace, _errorMethodCount);
    }

    final errorStr = event.error?.toString();

    final list = _formatAndPrint(
      event.level,
      messageStr,
      errorStr,
      stackTraceStr,
    );
    return list;
  }

  String stringifyMessage(message) {
    if (message is Map || message is Iterable) {
      final encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  String? formatStackTrace(StackTrace? stackTrace, int methodCount) {
    final lines = stackTrace.toString().split('\n');

    final formatted = <String>[];
    var count = 0;
    for (final line in lines) {
      final match = _stackTraceRegex.matchAsPrefix(line);
      if (match != null) {
        if (match.group(2)!.startsWith('package:logger')) {
          continue;
        }
        final newLine = '#$count   ${match.group(1)} (${match.group(2)})';
        formatted.add(newLine.replaceAll('<anonymous closure>', '()'));
        if (++count == methodCount) {
          break;
        }
      } else {
        formatted.add(line);
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String? error,
    String? stacktrace,
  ) {
    final formatted = <String>[];

    final emoji = _getEmoji(level);

    if (level == Level.error) {
      formatted.add('------EXCEPTION-------');
    }

    //Why chunkSize = 800?
    //print() function prints approx 800 - 1000 characters
    //on console, which was causing half of the logs to get trim.
    const chunkSize = 800;

    //message
    if (message.length <= chunkSize) {
      formatted.add('$emoji$message');
    } else {
      var startIndex = 0;
      while (startIndex < message.length) {
        final endIndex = startIndex + chunkSize;
        final actualEndIndex =
            endIndex < message.length ? endIndex : message.length;
        formatted.add(message.substring(startIndex, actualEndIndex));
        startIndex = endIndex;
      }
    }
    //error
    if (error != null) {
      for (final line in error.split('\n')) {
        formatted.add(line);
      }
    }

    //stackTrace
    if (stacktrace != null) {
      for (final line in stacktrace.split('\n')) {
        formatted.add('$line');
      }
    }
    if (level == Level.error) {
      formatted.add('----------------------');
    }
    return formatted;
  }

  String? _getEmoji(Level level) {
    return _levelEmojis[level];
  }
}
