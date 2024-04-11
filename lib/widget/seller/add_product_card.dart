import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/container/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProductCard extends StatelessWidget {
  const AddProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.color,
    this.isNetworkimage = false,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final Color color;
  final isNetworkimage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        width: 180,
        height: 200,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            RoundedContainer(
              height: 130,
              padding: EdgeInsets.all(1),
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  //photo
                  RoundedImage(
                    imageUrl: imageUrl,
                    applyImageRadius: true,
                    height: 150,
                    width: 150,
                    isNetworkImage: isNetworkimage,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    title: title,
                    smallSize: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
