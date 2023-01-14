import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';
import 'package:mini_git_dashboard/io/app_style.dart';
import 'package:mini_git_dashboard/ui/dashboard.dart';
import 'package:mini_git_dashboard/ui/no_network_view.dart';

GlobalKey<AppState> appKey = GlobalKey();

void rebuildApp() {
  appKey.currentState?.rebuild();
}

void main() async {
  await AppManager.initAppData();

  if(!AppManager.isLightMode()){
    await AppStyle.switchTheme(reload: false);
  }

  runApp(App(key: appKey));

  doWhenWindowReady(() {
    const initialSize = Size(400, 250);
    appWindow.minSize = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool online = false;

  void rebuild() => setState(() {});

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.vpn) {
        if (!online) {
          setState(() {
            online = true;
          });
        }
      } else {
        if (online) {
          setState(() {
            online = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: MaterialApp(
        color: AppStyle.backgroundColor,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppStyle.backgroundColor,
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: AppStyle.backgroundColor,
            child: Stack(children: [
              Visibility(
                  visible: online,
                  child:
                      Align(alignment: Alignment.center, child: Dashboard())),
              Visibility(
                  visible: !online,
                  child: Align(
                      alignment: Alignment.center, child: NoNetworkView())),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await AppStyle.switchTheme();
                            rebuildApp();
                          },
                          icon: Icon(
                            AppStyle.lightMode
                                ? Icons.nights_stay_rounded
                                : Icons.sunny,
                            color: AppStyle.lightMode
                                ? Colors.purple
                                : Colors.yellow,
                          ),
                          splashRadius: 25,
                        ),
                        Visibility(
                          visible: AppManager.isUserLoggedIn(),
                          child: IconButton(
                            onPressed: () async {
                              await AppManager.setLoggedIn(false);
                              rebuildApp();
                            },
                            icon: Icon(
                              Icons.logout,
                              color:
                                  AppStyle.lightMode ? Colors.blue : Colors.red,
                            ),
                            splashRadius: 25,
                          ),
                        ),
                      ],
                    )),
              ),
              Align(alignment: Alignment.center, child: MoveWindow()),
            ]),
          ),
        ),
      ),
    );
  }
}
