import 'package:bidcart/const/sizes.dart';
import 'package:flutter/material.dart';

class ProductLabelText extends StatelessWidget {
  const ProductLabelText(
      {super.key,
        required this.title,
        this.maxLines=1,
        this.fontsize=Sizes.fontSizeSm,

      });

  final String title;
  final int maxLines;
  final double fontsize;


  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:TextStyle(color: Colors.grey,fontSize:fontsize),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
