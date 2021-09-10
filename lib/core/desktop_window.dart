import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import '../constants/size_constants.dart';
import 'platform.dart';

/// Utils for desktop windows.

/// Sets up the desktop windows.
void setUpDesktopWindow() {
  if (currentPlatformType == PlatformType.windows) {
    doWhenWindowReady(() {
      const initialSize = kWindowSize;
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.maxSize = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  } else {
    setWindowMinSize(kWindowSize);
    setWindowMaxSize(kWindowSize);
  }
}
