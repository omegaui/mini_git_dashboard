import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/io/app_github_integrations.dart';
import 'package:mini_git_dashboard/io/app_images.dart';

const units = {
  {"value": 1e6, "unit": "M"},
  {"value": 1e3, "unit": "k"},
  {"value": 1e2, "unit": "H"},
  {"value": 1, "unit": ""}
};

const rankQuery = """
  query {
    viewer {
      repositories(first: 100, ownerAffiliations: OWNER, orderBy: {direction: DESC, field: STARGAZERS}) {
        nodes {
          stargazers {
            totalCount
          }
        }
      }
    }
  }
""";

const contributionQuery = """
  query {
    viewer {
      contributionsCollection {
        contributionCalendar {
          totalContributions
          weeks {
            contributionDays {
              contributionCount
              date
            }
          }
        }
      }
    }
  }
""";

int getTotalStargazersCount() {
  int count = 0;

  return count;
}

class UserDataProvider {
  static String getUsername() {
    return AppGitHubIntegrations.user.name ?? "";
  }

  static String getFollowers() {
    return convertToMetrics(AppGitHubIntegrations.user.followersCount ?? 0);
  }

  static String getFollowings() {
    return convertToMetrics(AppGitHubIntegrations.user.followingCount ?? 0);
  }



  static ImageProvider getTrophy(int stargazers) {
    if(stargazers >= 1000){
      return AppImages.trophySuper;
    }
    else if(stargazers >= 100){
      return AppImages.trophyA;
    }
    return AppImages.trophyOther;
  }

  static String convertToMetrics(count) {
    var countString = count.toString();
    var unit = "";
    for (var data in units) {
      if (count >= double.parse(data["value"].toString())) {
        unit = data["unit"] as String;
      }
    }
    if (unit.isNotEmpty) {
      count = count.floor().toInt();
      countString = "$count.${countString[1]}";
    }
    return countString;
  }

  static Widget getElemental(stargazers){
    if(stargazers >= 1000){
      return Icon(
        Icons.diamond_outlined,
        color: Colors.green,
      );
    }
    else if(stargazers >= 100){
      return Icon(
        Icons.local_fire_department_outlined,
        color: Colors.redAccent,
      );
    }
    return Icon(
      Icons.water_drop_outlined,
      color: Colors.blueAccent,
    );
  }

}
