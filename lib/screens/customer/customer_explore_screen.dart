import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/customer_controllers/customer_explore_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/widget/products/product_cards/explore_cards.dart';
import 'package:bidcart/widget/container/searchcontainer.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerExploreScreen extends StatefulWidget {
  const CustomerExploreScreen({super.key});

  @override
  State<CustomerExploreScreen> createState() => _CustomerExploreScreenState();
}

class _CustomerExploreScreenState extends State<CustomerExploreScreen> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CustomerExploreCardCOntroller());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Find Products ",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 19),
              ),
              const SizedBox(
                height: 20,
              ),
              const SearchContainer(
                text: 'Search in the Store',
                showBorder: false,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.toggleShowProducts();
                  },
                  child: Text("Go Back")),
              Obx(
                () {
                  if (controller.showProducts.value) {
                    return GridLayout(
                      mainAxisExtent: 180,
                      itemCount: controller.exploreCards.length,
                      itemBuilder: (context, index) {
                        final card = controller.exploreCards[index];
                        return GestureDetector(
                          onTap: () {
                            controller.setIndex(index);
                            print('Item at index ${index} tapped.');
                          },
                          child: ExploreCard(
                            imageUrl: card['imageUrl'],
                            title: card['title'],
                            color: card['color'],
                          ),
                        );
                      },
                    );
                  } else {
                            return GridLayout(
                              itemCount: controller.filteredList.length,
                              itemBuilder: (context, index) {
                                final product = controller.filteredList[index];
                                return ProductCardVertical(
                                  isNetworkImage: true,
                                  imageUrl: product.imageUrl,
                                  productTitle: product.name,
                                  quantity: product.quantity,
                                );
                              },
                            );
                  }
                },
              ),
            ]),
      ),
    );
  }
}
