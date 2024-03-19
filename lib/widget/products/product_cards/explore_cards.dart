import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/container/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard(
      {super.key,
        required this.imageUrl,
        required this.title,
        required this.color,
});

  final String imageUrl;
  final String title;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: color.withOpacity(0.3),
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
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(
                    title: title,
                    smallSize: true,
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
