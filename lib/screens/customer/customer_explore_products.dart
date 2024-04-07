import 'package:bidcart/controllers/customer_controllers/customer_explore_controller.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/customer/product_detail.dart';

import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
import 'package:bidcart/widget/container/searchcontainer.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreProducts extends StatefulWidget {
  const ExploreProducts({super.key});

  @override
  State<ExploreProducts> createState() => _ExploreProductsState();
}

class _ExploreProductsState extends State<ExploreProducts> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerExploreCardCOntroller());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TAppBar(showBackArrow: true, title: controller.getTitle(),actions: const [CartCounterIcon()],),
            const SearchContainer(
              text: 'Search here',
              showBorder: false,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: controller.filteredList.isEmpty
                    ? const Center(child: Text("Nothing here"))
                    : GridLayout(
                        itemCount: controller.filteredList.length,
                        itemBuilder: (context, index) {
                          final product = controller.filteredList[index];
                          return GestureDetector(
                            onTap: () {
                              controller.setIndex(index);
                              Get.to(ProductDetail(
                                id: product.id,
                                imageUrl: product.imageUrl,
                                description: product.description,
                                size: product.size,
                                category: product.category,
                                title: product.name,
                                quantity: product.quantity,
                              ));
                            },
                            child: ProductCardVertical(
                              isNetworkImage: true,
                              imageUrl: product.imageUrl,
                              productTitle: product.name,
                              size: product.size,
                              productId: product.id,
                              description: '',
                              quantity: 0,
                              counter: RxInt(product.quantity),
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
