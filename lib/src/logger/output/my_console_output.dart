import 'package:logger/logger.dart';

class MyConsoleOutput extends LogOutput {
  MyConsoleOutput({this.packageName});

  final String? packageName;

  @override
  void output(OutputEvent event) {
    event.lines.forEach((value) {
      if (packageName != null) {
        assert(() {
          print('${'${DateTime.now()}: $packageName: '}$value');
          return true;
        }(), '--');
      } else {
        assert(() {
          print('${'${DateTime.now()}: '}$value');
          return true;
        }(), '--');
      }
    });
  }
}
