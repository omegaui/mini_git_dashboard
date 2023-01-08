
import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_style.dart';
import 'package:mini_git_dashboard/main.dart';
import 'package:mini_git_dashboard/ui/neo_button.dart';

class NoNetworkView extends StatelessWidget{
  const NoNetworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "No Network Connection",
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 20),
        NeoButton(
          onPressed: () {
            rebuildApp();
          },
          width: 80,
          height: 30,
          borderRadius: 10,
          child: Text(
            "Retry",
            style: TextStyle(
                color: AppStyle.textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

}


