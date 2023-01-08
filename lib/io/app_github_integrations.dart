
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';

class AppGitHubIntegrations {
  static late GitHub gitHub;
  static late CurrentUser user;

  static Future<bool> performLogin() async {
    try {
      gitHub =
          GitHub(auth: Authentication.withToken(AppManager.getOAuthToken()));
      user = await gitHub.users.getCurrentUser();
      return true;
    }
    catch (e) {
      rethrow;
    }
  }
}



