import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/cart/add_remove_buttons.dart';
import 'package:bidcart/widget/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: Text("My Cart"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<ProductModel>>(
                  future: cartController.showCart(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                            'Cart is empty'), // Display message if cart is empty
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: Sizes.spaceBtwSections),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return Row(
                            children: [
                              CartItem(
                                  image: item.imageUrl,
                                  title: item.name,
                                  size: item.size),



                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: AddRemoveButtons(
                                          quantity:
                                              RxInt(int.parse(item.quantity))),
                                    ),
                                  ),

                              const SizedBox(height: Sizes.spaceBtwItems),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              // Adjust padding as needed
            ),
            child: const Text("Send Request"),
          ),
        ));
  }
}
