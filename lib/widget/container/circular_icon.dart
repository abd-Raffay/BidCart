import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({super.key, this.width, this.height, this.size, required this.icon, this.color, this.backgroundColor, this.onPressed});





  final double? width,height,size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;






  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor?.withOpacity((0.9)),
        borderRadius: BorderRadius.circular(100)
      ),
      child: IconButton(onPressed: onPressed,icon:Icon(icon ,color: color,size:size),),
    );
  }






}
