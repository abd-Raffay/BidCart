import 'package:flutter/material.dart';

class ProductLabelText extends StatelessWidget {
  const ProductLabelText(
      {super.key,
        required this.title,
        this.maxLines=1,

      });

  final String title;
  final int maxLines;


  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:TextStyle(color: Colors.grey,fontSize:13),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
