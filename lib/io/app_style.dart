import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';

import '../main.dart';

class AppStyle {
  static Color backgroundColor = const Color(0xFFEEF3FA);
  static Color neoBackgroundColor = const Color(0xFFE7EEF5);
  static Color neoBorderColor = Colors.amberAccent;
  static Color neoLightShadowColor = Colors.white.withOpacity(0.6);
  static Color neoDarkShadowColor = const Color(0xFFA3B1C6).withOpacity(0.6);
  static Color separatorColor = Colors.grey.shade300;
  static Color windowBorderColor = Colors.grey.shade400.withOpacity(0.4);
  static Color windowButtonBackground = Colors.grey.shade100;
  static Color windowButtonInActiveForeground = Colors.grey.shade700;
  static Color windowButtonActiveForeground = Colors.grey.shade900;
  static Color textColor = Colors.grey.shade900;

  static bool lightMode = true;

  static Future<void> switchTheme({reload = true}) async {
    lightMode = !lightMode;
    await AppManager.setLightMode(lightMode);
    if (lightMode) {
      backgroundColor = const Color(0xFFEEF3FA);
      neoBorderColor = Colors.amberAccent;
      neoBackgroundColor = const Color(0xFFE7EEF5);
      separatorColor = Colors.grey.shade300;
      windowBorderColor = Colors.grey.shade400.withOpacity(0.4);
      windowButtonBackground = Colors.grey.shade100;
      windowButtonInActiveForeground = Colors.grey.shade700;
      windowButtonActiveForeground = Colors.grey.shade900;
      textColor = Colors.grey.shade900;
      neoLightShadowColor = Colors.white.withOpacity(0.6);
      neoDarkShadowColor = const Color(0xFFA3B1C6).withOpacity(0.6);
    } else {
      backgroundColor = const Color(0xFF303234);
      neoBorderColor = Colors.blueAccent;
      neoBackgroundColor = const Color(0xFF303234);
      separatorColor = Colors.grey.shade700;
      windowBorderColor = Colors.grey.shade800.withOpacity(0.4);
      windowButtonBackground = Colors.grey.shade800;
      windowButtonInActiveForeground = Colors.grey.shade300;
      windowButtonActiveForeground = Colors.grey.shade100;
      textColor = Colors.grey.shade100;
      neoLightShadowColor = const Color(0xFF494949).withOpacity(0.4);
      neoDarkShadowColor = const Color(0xFF000000).withOpacity(0.4);
    }
    if (reload) {
      rebuildApp();
    }
  }
}
