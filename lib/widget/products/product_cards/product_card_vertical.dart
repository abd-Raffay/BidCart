import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/screens/customer/product_detail.dart';
import 'package:bidcart/widget/modal/product_modal.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/container/rounded_container.dart';

import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        Container(
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
                height: 130,
                width: 130,
                backgroundColor: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                   /*Get.to(ProductDetail(
                      id: productId,
                      imageUrl: imageUrl,
                      title: productTitle,
                      description: description,
                      size: size,
                      category: '',
                      quantity: quantity,
                    ));*/
                  },
                  child: RoundedImage(
                    imageUrl: imageUrl,
                    applyImageRadius: true,
                    height: 180,
                    width: 130,
                    isNetworkImage: isNetworkImage,
                  ),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems / 3),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          title: productTitle,
                          smallSize: true,
                        ),
                        Text(
                          size.join(','),
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        const SizedBox(height: Sizes.spaceBtwItems / 2),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              minimumSize: const Size(30, 30),
            ),
            onPressed: () async {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 320,
                    child: Modal(
                      quantity: quantity,
                      image: imageUrl,
                      title: productTitle,
                      sizes: size,
                      id: productId,
                    ),
                  );
                },
              );
              await cartController.getProductsList();
              // cartController.addProductstoCart(productId, "", "");
              // counter.value++;
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 16, // Adjust the icon size if needed
            ),
          ),
        ),
      ],
    );
  }
}
