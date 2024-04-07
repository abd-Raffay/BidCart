import 'package:bidcart/const/sizes.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText(
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
      style: const TextStyle(),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,



    );
  }
}
