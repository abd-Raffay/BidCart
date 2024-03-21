import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_home_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:bidcart/screens/common/grid_layout.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:bidcart/screens/product_detail.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/container/circular_container.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/container/searchcontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerHomeController());
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                //const TAppBar(),
                //logo
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(Images.logo),
                ),

                //search bar
                const SearchContainer(


                  text: 'Search in the Store',
                ),


                //Sliders
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            onPageChanged: (index, _) =>
                                controller.updatePageIndicator(index),
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
                        Center(
                          child: Obx(
                            () => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 0; i < 3; i++)
                                  CircularContainer(
                                      height: 4,
                                      width: 20,
                                      margin: const EdgeInsets.only(right: 10),
                                      backgroundColor: controller
                                                  .carousalCurrentIndex.value ==
                                              i
                                          ? Colors.cyan
                                          : Colors.grey),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),

                FutureBuilder<List<ProductModel>>(
                  future: controller.getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<ProductModel>? productList = snapshot.data;

                        return Expanded(
                          child: SingleChildScrollView(
                            child: GridLayout(
                              itemCount: productList!.length,
                              itemBuilder: (context, index) {
                                ProductModel product = productList[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.setIndex(index);
                                    Get.to( ProductDetail(imageUrl: product.imageUrl, description: product.description, quantity: product.quantity, category: product.category, title: product.name,));
                                  },
                                  child: ProductCardVertical(
                                    isNetworkImage: true,
                                    imageUrl: product.imageUrl,
                                    productTitle: product.name,
                                    quantity: product.quantity,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(
                          child: Text("Something Went Wrong"),
                        );
                      }
                    } else {
                      return const Column(
                        children: [
                          SizedBox(height: Sizes.defaultSpace*5),
                          Center(
                            child: CircularProgressIndicator(color: Colors.cyan,),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ])),
    );
  }
}
