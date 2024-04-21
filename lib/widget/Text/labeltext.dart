import 'package:bidcart/const/sizes.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText(
      {super.key,
        required this.title,
        //this.maxLines=1,
        this.fontsize=Sizes.fontSizeSm,
        this.color=Colors.grey,

      });

  final String title;
  //final int maxLines;
  final double fontsize;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:TextStyle(color: color,fontSize:fontsize),
      overflow: TextOverflow.ellipsis,
      //maxLines: maxLines,
    );
  }
}
