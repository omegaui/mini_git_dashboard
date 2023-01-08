import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_style.dart';
import 'package:mini_git_dashboard/ui/dashboard.dart';

void main() {
  runApp(const App());

  doWhenWindowReady(() {
    const initialSize = Size(400, 250);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: MaterialApp(
        color: AppStyle.backgroundColor,
        home: Scaffold(
          backgroundColor: AppStyle.backgroundColor,
          body: MoveWindow(child: const Dashboard()),
        ),
      ),
    );
  }

}


