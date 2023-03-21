import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/ui/graph_block.dart';

class ContributionGraph extends StatelessWidget {
  const ContributionGraph({super.key, required this.contributions});

  final dynamic contributions;

  List<Widget> _buildBlocks() {
    List<Widget> rows = [];
    dynamic orderedContributions = contributions.reversed.toList();
    dynamic fetchList = [];
    for (var i = 0; i < orderedContributions.length; i++) {
      var days = orderedContributions
          .elementAt(i)['contributionDays']
          .reversed
          .toList();
      for (var day in days) {
        fetchList.add([day['contributionCount'], day['date']]);
      }
    }
    int k = 0;
    for (var i = 0; i < 3; i++) {
      List<Widget> widgets = [];
      for (var j = 0; j < 6; j++) {
        int contributionCount = fetchList[k][0];
        String date = fetchList[k++][1];
        widgets
            .add(GraphBlock(contributionCount: contributionCount, date: date));
      }
      rows.add(Wrap(spacing: 4, children: widgets));
      rows.add(const SizedBox(
        height: 4,
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 72,
      child: Column(
        children: _buildBlocks(),
      ),
    );
  }
}
