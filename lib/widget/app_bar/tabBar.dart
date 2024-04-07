import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget>? tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TabBar(
        dividerColor: Colors.grey.shade200,
        isScrollable: true,
        tabs: tabs!,
        indicatorColor: Colors.cyan,
        labelColor: Colors.cyan,
        unselectedLabelColor: Colors.grey,
        dividerHeight: 1,
        overlayColor: MaterialStateProperty.all(Colors.grey.shade100),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(25.0);
}
