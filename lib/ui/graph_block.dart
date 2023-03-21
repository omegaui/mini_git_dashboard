import 'package:flutter/material.dart';

import '../io/app_style.dart';

class GraphBlock extends StatefulWidget {
  const GraphBlock(
      {super.key, required this.contributionCount, required this.date});

  final int contributionCount;
  final String date;

  @override
  State<GraphBlock> createState() => _GraphBlockState();
}

class _GraphBlockState extends State<GraphBlock> {
  bool hover = false;

  Color inferColor(int contributionCount) {
    if (contributionCount > 0) {
      if (contributionCount <= 2) {
        return const Color(0xFF82F380);
      } else if (contributionCount <= 4) {
        return const Color(0xFF46DB43);
      }
      return const Color(0xFF0E890C);
    }
    return Colors.grey.withOpacity(0.2);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "${widget.contributionCount} on ${widget.date}",
      textStyle: TextStyle(
          fontFamily: "Ubuntu Mono", fontSize: 12, color: AppStyle.textColor),
      decoration: BoxDecoration(
        color: AppStyle.neoBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: AppStyle.lightMode
                  ? Colors.red.withOpacity(0.4)
                  : Colors.blue.withOpacity(0.4),
              blurRadius: 4,
              spreadRadius: 4),
        ],
      ),
      child: MouseRegion(
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: hover ? 15 : 20,
          height: hover ? 15 : 20,
          decoration: BoxDecoration(
              color: inferColor(widget.contributionCount),
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: Colors.grey.withOpacity(0.2), width: 1)),
        ),
      ),
    );
  }
}
