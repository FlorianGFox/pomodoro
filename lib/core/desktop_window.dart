import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/constants/size_constants.dart';
import 'package:pomodoro/core/platform.dart';
import 'package:window_size/window_size.dart';

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
