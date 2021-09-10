import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Collection of functions to determine the current platform.

/// Returns true if the app is running on desktop (MacOS, Linux or Windows).
bool platformIsDesktop() {
  return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
}

/// Returns true if the app is running on mobile.
bool platformIsMobile() {
  return Platform.isIOS || Platform.isAndroid;
}

/// Returns true if the app is running on web.
bool platformIsWeb() {
  return kIsWeb;
}

/// Platform type the app is running currently on.
PlatformType get currentPlatformType {
  if (kIsWeb) {
    return PlatformType.web;
  }
  if (Platform.isMacOS) {
    return PlatformType.macOS;
  }
  if (Platform.isFuchsia) {
    return PlatformType.fuchsia;
  }
  if (Platform.isLinux) {
    return PlatformType.linux;
  }
  if (Platform.isWindows) {
    return PlatformType.windows;
  }
  if (Platform.isIOS) {
    return PlatformType.iOS;
  }
  if (Platform.isAndroid) {
    return PlatformType.android;
  }
  return PlatformType.unknown;
}

/// All available platform types.
enum PlatformType {
  /// Platform is web.
  web,

  /// Platform is iOS system.
  iOS,

  /// Platform is Android system.
  android,

  /// Platform is MacOS system.
  macOS,

  /// Platform is Fuchsia system.
  fuchsia,

  /// Platform is Linux system.
  linux,

  /// Platform is Windows system.
  windows,

  /// Platform is unknown.
  unknown,
}
