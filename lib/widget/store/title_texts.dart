import 'package:bidcart/const/sizes.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {super.key,
        required this.title,
        this.smallSize =false,
        this.maxLines=2,
        this.textAlign=TextAlign.left,
        this.fontSize=Sizes.fontSizeSm
      });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w300,fontSize: Sizes.fontSizeMd),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
