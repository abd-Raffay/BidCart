import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.buttontext,
  });

  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          // Adjust padding as needed
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.cart),
            const SizedBox(width: 20,),
            Text(buttontext),

          ],
        ),
      ),

    );
  }
}