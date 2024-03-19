import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
        this.width,
        this.height,
        this.radius=16.0,
        this.padding,
        this.margin,
        this.child,
        this.backgroundColor=Colors.white,
        this.showBorder=false,
        this.borderColor=Colors.white70,
      });

  final double? width;
  final double? height;
  final double? radius;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin:margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor):null,
      ),
      child: child,

    );
  }
}
