import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/widget/container/circular_container.dart';
import 'package:bidcart/widget/container/rounded_container.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryCardVertical extends StatelessWidget {
  const InventoryCardVertical({
    Key? key,
    required this.product,
    required this.isNetworkImage,
  }) : super(key: key);

  final Inventory product;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final homeController=Get.put(SellerHomeController());
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
      child: Stack(
        children: [

          Column(
            children: [
              RoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(1),
                backgroundColor: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    // Handle card tap
                  },
                  child: Stack(
                    children: [
                      //photo
                      RoundedImage(
                        imageUrl: product.imageUrl,
                        applyImageRadius: true,
                        height: 180,
                        width: 130,
                        isNetworkImage: isNetworkImage,
                      ),
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
                    TitleText(
                      title: product.name,
                      smallSize: true,
                    ),
                    Row(
                      children: [
                        TitleText(
                          title: product.size.toString(),
                          smallSize: true,
                        ),
                        TitleText(
                          title: ", ",
                          smallSize: true,
                        ),
                        TitleText(
                          title: product.price.toString(),
                          smallSize: true,
                        ),
                        TitleText(
                          title: "Rs ,",
                          smallSize: true,
                        ),
                        TitleText(
                          title: product.quantity.toString(),
                          smallSize: true,
                        ),

                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () {
                homeController.showDeleteDialog(context,product.inventoryid);

                print("ItemDeleted");
                // Handle delete icon tap
              },
              child: CircularContainer(
                backgroundColor: Colors.red.shade400,
                width: 30,
                height: 30,
                child: Center(
                  child: Icon(
                    CupertinoIcons.bin_xmark,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 45,
            top: 10,
            child: GestureDetector(
              onTap: () {
                homeController.showUpdateDialog(context,product.inventoryid);
              },
              child: CircularContainer(
                backgroundColor: Colors.cyan,
                width: 30,
                height: 30,
                child: Center(
                  child: Icon(
                    CupertinoIcons.add,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
