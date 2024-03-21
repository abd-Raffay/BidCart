import 'package:bidcart/controllers/customer_controllers/customer_home_controller.dart';
import 'package:bidcart/repository/customer_repository/customer_home_repository.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/screens/product_detail.dart';
import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/container/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical(
      {super.key,
      required this.imageUrl,
      required this.productTitle,
      required this.quantity,
        required this.isNetworkImage,

        });

  final String imageUrl;
  final String productTitle;
  final String quantity;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0, 2),
              spreadRadius: 7,
              blurRadius: 50,
            ),
          ],
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Column(
          children: [

             RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(1),
              backgroundColor: Colors.white,
              child: Stack(
                children: [

                  //photo
                  RoundedImage(
                    imageUrl: imageUrl,
                    applyImageRadius: true,
                    height: 180,
                    width: 130,
                    isNetworkImage: isNetworkImage,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ProductTitleText(
                    title: productTitle,
                    smallSize: true,
                  ),
                  //const SizedBox(height: 8.0),
                   ProductLabelText(title: quantity),
                  const SizedBox(
                    height: 12.5,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(16.0),
                          )),
                      child: const SizedBox(
                          width: 32 * 1.2,
                          height: 32 * 1.2,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
