import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 16.0,
    this.applyImageRadius = true,
  });

  final double? width, height;
  final String imageUrl;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  final double borderRadius;
  final bool applyImageRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
          child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child:isNetworkImage ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: fit,
               //progressIndicatorBuilder: (context,url,downloadProgress) => Shimmer,
              errorWidget: (context,url,error) =>const Icon(Icons.error),
            ): Image(
                fit: fit,
                image: AssetImage(imageUrl),
                //image: isNetworkImage
                  //  ? NetworkImage(imageUrl)
                   // : AssetImage(imageUrl) as ImageProvider),
          )
                ),
    )
    );
  }
}
