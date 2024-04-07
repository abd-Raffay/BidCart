import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/screens/customer/product_detail.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/modal/product_modal.dart';
import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/container/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controllers/customer_controllers/customer_cart_controller.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    required this.imageUrl,
    required this.productTitle,
    required this.size,
    required this.isNetworkImage,
    required this.productId,
    required this.description,
    required this.quantity,
    required this.counter,
  });

  final String imageUrl;
  final String productTitle;
  final String description;
  final int quantity;
  final List<String> size;
  final bool isNetworkImage;
  final String productId;
  final RxInt counter;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Container(
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
            child: GestureDetector(
              onTap: () {
                Get.to(ProductDetail(
                  id: productId,
                  imageUrl: imageUrl,
                  title: productTitle,
                  description: description,
                  size: size,
                  category: '',
                  quantity: quantity,
                ));
              },
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
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _________ Product heading and sub heading _------__-___---
                TitleText(
                  title: productTitle,
                  smallSize: true,
                ),
                Text(
                  size.join(','),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                //ProductLabelText(title: size),

                // ---- ADD BUTTON -----
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 1),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16)),
                      child: IconButton(
                          onPressed: () async {
                            showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                builder: ((context) {
                                  return Container(
                                      height: 270,
                                      child: Modal(
                                        image: imageUrl,
                                        title: productTitle,
                                        sizes: size,
                                        id: productId,
                                      ));
                                })
                            );
                            await cartController.getProductsList();
                            //cartController.addProductstoCart(productId, "","");
                            //counter.value++;
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
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
