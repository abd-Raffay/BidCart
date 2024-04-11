import 'package:bidcart/controllers/seller_controllers/seller_store_controller.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/seller/seller_add_products.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/products/product_cards/explore_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerAddScreen extends StatefulWidget {
  const SellerAddScreen({super.key});

  @override
  State<SellerAddScreen> createState() => _SellerAddScreenState();
}
bool isChecked = false;

class _SellerAddScreenState extends State<SellerAddScreen> {
  @override
  Widget build(BuildContext context) {
    final storeController = Get.put(SellerStoreController());

    return Scaffold(
      appBar: const TAppBar(
        title: Text("Add Screen"),


      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GridLayout(
                  mainAxisExtent: 180,
                  itemCount: storeController.exploreCards.length,
                  itemBuilder: (context, index) {
                    final card = storeController.exploreCards[index];
                    return GestureDetector(
                      onTap: () {
                        storeController.setIndex(index);
                        Get.to(const AddProducts());
                      },
                      child: ExploreCard(
                        imageUrl: card['imageUrl'],
                        title: card['title'],
                        color: card['color'],

                      ),
                    );
                  },
                ),
              ),
            )
              ],
            ),
      )
    );








  }
}
