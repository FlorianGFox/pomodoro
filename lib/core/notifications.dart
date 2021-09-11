import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quick_notify/quick_notify.dart';

import 'desktop_window.dart';
import 'platform.dart';

@singleton
class Notifications {
  /// Handles notifications.
  ///
  /// For platform Android, iOS and MacOS.
  /// Is only initialized for the those platforms.
  /// Method [initialize] needs to be called to initialize this.
  FlutterLocalNotificationsPlugin? flutterNotificationPlugin;

  /// Plays audio
  ///
  /// For platform Android, iOS, MacOS and Web.
  /// It is only initialized for those platforms.
  /// Method [initialize] needs to be called to initialize this.
  AudioPlayer? player;

  /// Platform the app is currently running on.
  /// Method [initialize] needs to be called to initialize this.
  late PlatformType platform;

  Future<bool?> initialize() async {
    platform = currentPlatformType;

    if (platform == PlatformType.macOS) {
      flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettingsMacOS = MacOSInitializationSettings(
        requestBadgePermission: false,
      );
      const initializationSettings = InitializationSettings(
        macOS: initializationSettingsMacOS,
      );

      await flutterNotificationPlugin!.initialize(
        initializationSettings,
        onSelectNotification: (_) async => activateWindow(),
      );

      return flutterNotificationPlugin!
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    if (platform == PlatformType.android ||
        platform == PlatformType.iOS ||
        platform == PlatformType.macOS ||
        platform == PlatformType.web) {
      player = AudioPlayer();
    }

    return true;
  }

  Future<void> show({
    String? title,
    String? subtitle,
    required String message,
  }) async {
    if (flutterNotificationPlugin != null && platform == PlatformType.macOS) {
      await flutterNotificationPlugin!.show(
        0,
        title,
        message,
        NotificationDetails(
          macOS: MacOSNotificationDetails(
            subtitle: subtitle,
          ),
        ),
      );
    } else {
      QuickNotify.notify(content: message);
    }
  }

  Future<void> playSound(String soundfile) async {
    if (player != null) {
      await player!.setAsset(soundfile);
      await player!.play();
      await player!.seekToPrevious();
    }
  }
}
