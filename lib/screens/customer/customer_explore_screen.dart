import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/customer_controllers/customer_explore_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/customer/customer_explore_products.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/products/product_cards/explore_cards.dart';
import 'package:bidcart/widget/container/searchcontainer.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const TAppBar(title: Text("Find Products"),),
              const SearchContainer(
                text: 'Search here',
                showBorder: false,
              ),
              const SizedBox(
                height: 10,
              ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: GridLayout(
                          mainAxisExtent: 180,
                          itemCount: controller.exploreCards.length,
                          itemBuilder: (context, index) {
                            final card = controller.exploreCards[index];
                            return GestureDetector(
                              onTap: () {
                                controller.setIndex(index);
                                Get.to(const ExploreProducts());
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
            ]),
      ),
    );
  }
}
