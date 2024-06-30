import 'package:flutter/material.dart';

class GridLayout extends StatelessWidget {
  const GridLayout(
      {super.key,
      required this.itemCount,
      this.mainAxisExtent = 190,
      required this.itemBuilder});

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          mainAxisExtent: mainAxisExtent,
        ),
        itemBuilder: itemBuilder);
  }
}
