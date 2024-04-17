
import 'package:bidcart/controllers/seller_controllers/seller_store_controller.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/seller/seller_addproduct_detail.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
import 'package:bidcart/widget/container/searchcontainer.dart';
import 'package:bidcart/widget/seller/add_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(CustomerExploreCardCOntroller());
    final storeController = Get.put(SellerStoreController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const TAppBar(
              showBackArrow: true,
              title: Text("Products"),
              //actions: [CartCounterIcon()],
            ),
            const SearchContainer(
              text: 'Search here',
              showBorder: false,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: storeController.filteredList.isEmpty
                    ? const Center(child: Text("Nothing here"))
                    : GridLayout(
                        mainAxisExtent: 180,
                        itemCount: storeController.filteredList.length,
                        itemBuilder: (context, index) {
                          final product = storeController.filteredList[index];
                          return GestureDetector(
                            onTap: () {
                              storeController.setIndex(index);
                              Get.to(()=> SellerProductDetail(
                                product: product,
                              ));
                            },
                            child: AddProductCard(
                              imageUrl: product.imageUrl,
                              title: product.name,
                              color: Colors.grey,
                              isNetworkimage: true,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
