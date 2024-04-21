import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/products/product_cards/inventory_card.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({Key? key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  final homeController = Get.put(SellerHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Images.logo,
        title: const Text("Inventory"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridLayout(
                        mainAxisExtent: 250,
                        itemCount: homeController.rxInventory.length,
                        itemBuilder: (context, index) {
                          Inventory product =
                          homeController.rxInventory[index];
                          return GestureDetector(
                            onTap: () {
                              homeController.setIndex(index);
                            },
                            child: InventoryCardVertical(
                              isNetworkImage: true,
                              product: product,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
