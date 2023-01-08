
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_git_dashboard/io/app_github_integrations.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';
import 'package:mini_git_dashboard/io/app_style.dart';
import 'package:mini_git_dashboard/main.dart';
import 'package:mini_git_dashboard/ui/neo_button.dart';

class HomeView extends StatelessWidget{
  const HomeView({super.key});

  Widget _buildView(BuildContext context){
    return FutureBuilder(
      future: AppGitHubIntegrations.performLogin(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                color: AppStyle.textColor,
                size: 96,
              ),
              const SizedBox(height: 10),
              Text(
                "Authenticating...",
                style: TextStyle(
                  color: AppStyle.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
        if(snapshot.hasError){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.sms_failed_outlined,
                color: AppStyle.textColor,
                size: 96,
              ),
              const SizedBox(height: 10),
              Text(
                "Authentication Failed\nEither due to network or invalid token",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppStyle.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeoButton(
                    width: 80,
                    height: 30,
                    onPressed: () {
                      rebuildApp();
                    },
                    child: Text(
                      "Re-try",
                      style: TextStyle(
                          color: AppStyle.textColor
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  NeoButton(
                    width: 80,
                    height: 30,
                    onPressed: () async {
                      await AppManager.setLoggedIn(false);
                      rebuildApp();
                    },
                    child: Text(
                      "Re-login",
                      style: TextStyle(
                          color: AppStyle.textColor
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }
        return _buildDashboard(context);
      },
    );
  }

  Widget _buildDashboard(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeoButton(
              radius: 60,
              borderRadius: 40,
              onPressed: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: NetworkImage(AppGitHubIntegrations.user.avatarUrl as String),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

}



