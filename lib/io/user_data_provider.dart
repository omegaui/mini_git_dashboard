import 'dart:math';

import 'package:mini_git_dashboard/io/app_github_integrations.dart';
import 'package:http/http.dart' as http;

const units = {
  {"value": 1e6, "unit": "M"},
  {"value": 1e3, "unit": "k"},
  {"value": 1e2, "unit": "H"},
  {"value": 1, "unit": ""}
};

const countStargazersQuery = """
  query {
    viewer {
      starredRepositories {
        totalCount
      }
    }
  }
""";

int getTotalStargazersCount(){
  int count = 0;

  return count;
}

double normalcdf(mean, sigma, to) {
  var z = (to - mean) / sqrt(2 * sigma * sigma);
  var t = 1 / (1 + 0.3275911 * double.parse(z).abs());
  var a1 = 0.254829592;
  var a2 = -0.284496736;
  var a3 = 1.421413741;
  var a4 = -1.453152027;
  var a5 = 1.061405429;
  var erf =
      1 - ((((a5 * t + a4) * t + a3) * t + a2) * t + a1) * t * exp(-z * z);
  var sign = 1;
  if (z < 0) {
    sign = -1;
  }
  return (1 / 2) * (1 + sign * erf);
}

String calculateRank(
    {totalRepos,
    totalCommits,
    contributions,
    followers,
    prs,
    issues,
    stargazers}) {
  var commitsOffset = 1.65;
  var contributionsOffset = 1.65;
  var issuesOffset = 1;
  var starsOffset = 0.75;
  var prsOffset = 0.5;
  var followersOffset = 0.45;
  var reposOffset = 1;

  var allOffsets = contributionsOffset +
      issuesOffset +
      starsOffset +
      prsOffset +
      followersOffset +
      reposOffset;

  var randSValue = 1;
  var rankDoubleAValue = 25;
  var rankA2Value = 45;
  var rankA3Value = 60;
  var rankBValue = 100;

  var totalValues = randSValue +
      rankDoubleAValue +
      rankA2Value +
      rankA3Value +
      rankBValue;

  var score = (totalCommits * commitsOffset +
          contributions * contributionsOffset +
          issues * issuesOffset +
          stargazers * starsOffset +
          prs * prsOffset +
          followers * followersOffset +
          totalRepos * reposOffset) /
      100;

  var normalizedScore = normalcdf(score, totalValues, allOffsets) * 100;

  if (normalizedScore < randSValue) return "S+";
  if (normalizedScore < rankDoubleAValue) return "S";
  if (normalizedScore < rankA2Value) return "A++";
  if (normalizedScore < rankA3Value) return "A+";
  return "B+";
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

  // static Future<String> getRank() async {
  //   return calculateRank(
  //     contributions: AppGitHubIntegrations.user.diskUsage,
  //     followers: AppGitHubIntegrations.user.followersCount,
  //     issues: await AppGitHubIntegrations.gitHub.issues.listAll().length,
  //     prs: await AppGitHubIntegrations.,
  //     stargazers: ,
  //     totalCommits: ,
  //     totalRepos:
  //   );
  // }
}
