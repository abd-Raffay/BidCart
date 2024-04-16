import 'package:bidcart/const/images.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bidcart/controllers/customer_controllers/customer_home_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
import 'package:bidcart/widget/container/circular_container.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:bidcart/widget/container/round_image.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final homeController = Get.put(CustomerHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        leadingIcon: Images.logo,
        title: Text("BidCart"),
        actions: [
          CartCounterIcon(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, _) =>
                        homeController.updatePageIndicator(index),
                  ),
                  items: const [
                    RoundedImage(
                      imageUrl: Images.banner1,
                      isNetworkImage: true,
                    ),
                    RoundedImage(
                      imageUrl: Images.banner2,
                      isNetworkImage: true,
                    ),
                    RoundedImage(
                      imageUrl: Images.banner3,
                      isNetworkImage: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < 3; i++)
                        CircularContainer(
                          height: 4,
                          width: 20,
                          margin: const EdgeInsets.only(right: 10),
                          backgroundColor:
                              homeController.carousalCurrentIndex.value == i
                                  ? Colors.cyan
                                  : Colors.grey,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: homeController.search,
              onChanged: (value) {
                homeController.filterProducts(value);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),

                  labelText: 'Search here',
                  labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(20),

                )
              ),
            ),
          ),
          Obx(() {
            final productList = homeController.filteredProducts();
            if (productList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.cyan,
                ),
              );
            } else {
              return Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridLayout(
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final product = productList[index];
                        return GestureDetector(
                          onTap: () {
                            homeController.setIndex(index);
                          },
                          child: ProductCardVertical(
                            isNetworkImage: true,
                            imageUrl: product.imageUrl,
                            productTitle: product.name,
                            size: product.size,
                            productId: product.id,
                            description: product.description,
                            quantity: product.quantity,
                            counter: RxInt(product.quantity),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
