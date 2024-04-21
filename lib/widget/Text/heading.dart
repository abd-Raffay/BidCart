import 'package:bidcart/const/sizes.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText(
      {super.key,
        required this.title,
        this.maxLines=1,
        this.fontsize=Sizes.fontSizeMd,

      });

  final String title;
  final int maxLines;
  final double fontsize;


  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:TextStyle(fontSize:fontsize),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
