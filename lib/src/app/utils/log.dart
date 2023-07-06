import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final styledLogProvider = Provider<StyledLog>(
  (ref) => StyledLog(
    logger: Logger(
      printer: PrettyPrinter(
        colors: true,
        printTime: true,
        printEmojis: true,
      ),
    ),
  ),
);

class StyledLog {
  final Logger _logger;

  StyledLog({required Logger logger}) : _logger = logger;

  void d(dynamic message) {
    _logger.d(message);
  }

  void e(dynamic message) {
    _logger.e(message);
  }

  void i(dynamic message) {
    _logger.i(message);
  }

  void v(dynamic message) {
    _logger.v(message);
  }

  void w(dynamic message) {
    _logger.w(message);
  }

  void wtf(dynamic message) {
    _logger.wtf(message);
  }
}
