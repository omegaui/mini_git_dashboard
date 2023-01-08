import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_images.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';
import 'package:mini_git_dashboard/io/app_style.dart';
import 'package:mini_git_dashboard/main.dart';
import 'package:mini_git_dashboard/ui/neo_button.dart';

var status = "";

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController loginFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "OAuth Token Required",
          style: TextStyle(
              color: AppStyle.textColor,
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Image(
          image: AppImages.github,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 200,
          child: TextField(
            obscureText: true,
            controller: loginFieldController,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppStyle.textColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Paste your OAuth Token here",
              hintStyle: TextStyle(
                fontFamily: "Ubuntu Mono",
                color: AppStyle.textColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                NeoButton(
                  width: 80,
                  height: 30,
                  onPressed: () async {
                    if (loginFieldController.text.isEmpty) {
                      setState(() {
                        status = "Token is required!";
                      });
                      return;
                    }
                    setState(() {
                      status = "";
                    });
                    await AppManager.saveOAuthToken(loginFieldController.text);
                    await AppManager.setLoggedIn(true);
                    rebuildApp();
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: AppStyle.textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
