import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/widget/cart/add_remove_buttons.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, required this.title, required this.size, required this.image,
  });

  final String title;
  final String size;
  final String image;


  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
         RoundedImage(
            imageUrl: image,
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(Sizes.sm),
           isNetworkImage: true,

        ),
        const SizedBox(width: Sizes.spaceBtwItems,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTitleText(title: title),
            ProductLabelText(title: size),
          ],

        ),
      ],
    );
  }
}