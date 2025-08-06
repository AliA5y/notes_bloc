// lib/core/utils/app_logger.dart

import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  static void info(String message, {String tag = 'INFO'}) {
    _log('📘 [$tag]', message);
  }

  static void success(String message, {String tag = 'SUCCESS'}) {
    _log('✅ [$tag]', message);
  }

  static void warning(String message, {String tag = 'WARNING'}) {
    _log('⚠️ [$tag]', message);
  }

  static void error(String message, {String tag = 'ERROR'}) {
    _log('❌ [$tag]', message);
  }

  static void debug(String message, {String tag = 'DEBUG'}) {
    _log('🐞 [$tag]', message);
  }

  static void _log(String prefix, String message) {
    if (kDebugMode) {
      // Only logs in debug mode
      log('$prefix $message');
    }
  }
}
