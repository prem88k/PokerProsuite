import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class QAItem extends StatefulWidget {
  const QAItem({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final Widget title;

  final List<Widget> children;

  @override
  State<QAItem> createState() => _QAItemState();
}

class _QAItemState extends State<QAItem> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: appColor,
      trailing: isExpanded ? Icon(Icons.minimize_outlined,color: appColor,) : Icon(Icons.add,color: appColor),
      title: widget.title,
      children: widget.children,
      onExpansionChanged: (bool expanded) {
        setState(() => isExpanded = expanded);
      },
    );
  }
}
