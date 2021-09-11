import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../constants/size_constants.dart';
import 'platform.dart';

/// Utils for desktop windows.

/// Sets up the desktop windows.
///
/// It does nothing if the current platform is not desktop.
void setUpDesktopWindow() {
  if (platformIsDesktop()) {
    doWhenWindowReady(() {
      const initialSize = kWindowSize;
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.maxSize = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

bool isWindowVisible() {
  if (platformIsDesktop()) {
    return appWindow.isVisible;
  }

  return false;
}

void activateWindow() {
  if (platformIsDesktop()) {
    return appWindow.show();
  }
}
