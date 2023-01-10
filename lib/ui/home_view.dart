
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_git_dashboard/io/app_github_integrations.dart';
import 'package:mini_git_dashboard/io/app_images.dart';
import 'package:mini_git_dashboard/io/app_manager.dart';
import 'package:mini_git_dashboard/io/app_style.dart';
import 'package:mini_git_dashboard/io/user_data_provider.dart';
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
    final HttpLink httpLink = HttpLink(
        'https://api.github.com/graphql',
        defaultHeaders: {"authorization": "Bearer ${AppManager.getOAuthToken()}"});

    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache: GraphQLCache()));
    return GraphQLProvider(
      client: client,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image(
              image: AppStyle.lightMode ? AppImages.landscape : AppImages.night,
              width: 160,
              height: 160,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NeoButton(
                          onPressed: () {},
                          radius: 25,
                          borderRadius: 40,
                          lightShadowColor: const Color(0xFF1530BF).withOpacity(0.25),
                          darkShadowColor: const Color(0xFF161EE4).withOpacity(0.25),
                          shadowBlurRadius: 16,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image(
                              image: NetworkImage(AppGitHubIntegrations.user.avatarUrl as String),
                            ),
                          ),
                        ),
                        const SizedBox(width: 11),
                        Text(
                          "Hi! ",
                          style: TextStyle(
                            color: AppStyle.textColor,
                            fontFamily: "Ubuntu Mono",
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          UserDataProvider.getUsername(),
                          style: TextStyle(
                            color: AppStyle.textColor,
                            fontFamily: "Ubuntu Mono",
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 48),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/108894-people.json',
                          width: 100,
                          height: 77.8),
                      Text(
                        "${UserDataProvider.getFollowers()} friends",
                        style: TextStyle(
                            color: AppStyle.textColor,
                            fontFamily: "Ubuntu Mono",
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/133155-cute-robot-money-p3.json',
                          width: 77.8,
                          height: 77.8),
                      Text(
                        "${UserDataProvider.getFollowers()} followings",
                        style: TextStyle(
                            color: AppStyle.textColor,
                            fontFamily: "Ubuntu Mono",
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Query(
                    options: QueryOptions(
                      document: gql(countStargazersQuery),
                    ),
                    builder: (result, {fetchMore, refetch}) {
                      if(result.hasException){
                        return Text("error");
                      }
                      if(result.isLoading){
                        return Text("loading");
                      }
                      print(result);
                      return Text((result.data?['viewer']['starredRepositories']['totalCount'] as int).toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

}



