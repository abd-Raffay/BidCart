import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_explore_controller.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/customer/product_detail.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
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
  final controller = Get.put(CustomerExploreCardCOntroller());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TAppBar(
              showBackArrow: true,
              title: controller.getTitle(),
              actions: const [CartCounterIcon()],

            ),
            SizedBox(height: Sizes.spaceBtwItems,),
            TextField(
              controller: searchController,
              onChanged: (value) {
                controller.filterProducts(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search a Product",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Obx(() {
                final productList = controller.filteredProducts;
                if (productList().isEmpty) { // Notice the added function call 'productList()'
                  return const Center(child: Text("Nothing here"));
                } else {
                  return SingleChildScrollView(
                    child: GridLayout(
                      itemCount: productList().length, // Also added function call here
                      itemBuilder: (context, index) {
                        final product = productList()[index]; // And here
                        return GestureDetector(
                          onTap: () {
                            controller.setIndex(index);

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
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
