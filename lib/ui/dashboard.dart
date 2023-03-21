import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppManager.getView();
  }
}
